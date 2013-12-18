require 'uri'
require "net/http"
require 'wombat'
require 'duke_of_url'

class UrlStats
  include Wombat::Crawler

  LIST_MODE   = :list
  SPIDER_MODE = :spider

  def self.sensor_name
    'URL Stats Sensor'
  end

  def self.process(mode, url, path = '/')
    results = {
      sensor: sensor_name,
      mode: mode,
      sha1: DukeOfUrl::SHA1.hexdigest(url),
      seed_url: url,
      time: Time.now.utc,
      stats: {},
      urls: []
    }

    results.merge! work({ url: url, path: path, mode: mode })
    results
  end

  private

  def self.work(config = {})
    url, path, mode = config[:url], config[:path], config[:mode]

    payload = {}.tap { |payload|
      payload.merge! url_status(url)

      if payload[:status] < 400
        crawl_results = crawl.call(url, mode)
        payload.merge! data_fields(crawl_results)
        payload.merge! check_urls(url, crawl_results)
      end
    }
    payload
  end

  def self.crawl
    return lambda { |url, mode|
      instructions = get_instructions(mode)
      return Wombat.crawl do
        mp = Mechanize.new.get url
        @metadata_dup.page(mp)
        instructions.each { |op| op.call(@metadata_dup) }
      end
    }
  end

  def self.get_instructions(mode)
    instructions = [get_stats]
    case mode
    when SPIDER_MODE.to_s
      instructions << get_urls
    end
    instructions
  end

  def self.get_stats
    return lambda { |metadata|
      metadata.canonical 'xpath=/html/head//link[@rel="canonical"]/@href'
      metadata.description 'xpath=/html/head//meta[@name="description"]/@content'
    }
  end

  def self.get_urls
    return lambda { |metadata|
      metadata.links 'xpath=/html/body//a', :iterator do
        link_text 'xpath=./text()'
        url 'xpath=./@href'
      end
    }
  end

  def self.data_fields(crawl_results)
    {
      fields: {
        canonical: crawl_results['canonical'],
        description: crawl_results['description']
        }
    }
  end

  def self.check_urls(url, crawl_results)
    return {} if crawl_results.nil? || crawl_results['links'].nil?

    uri, urls = URI(url), {}

    urls = crawl_results['links'].select! { |u|
      u if domain_url?(uri.host, u['url'])
    }.each { |u|
      u[:sha1] = DukeOfUrl::SHA1.hexdigest(u['url'])
      u[:stats] = work({ url: u['url'], mode: LIST_MODE })
    }

    { urls: urls }
  end

  def self.domain_url?(host, u)
    return false if u.nil?
    u.match Regexp.new "^((http|https):\/\/)?#{host}\/"
  end

  def self.url_status(u)
    status = begin
               url = URI.parse(u.end_with?('/') ? u : "#{u}/")
               req = Net::HTTP.new(url.host, url.port)
               res = req.request_head(url.path)
               res.code.to_i
             rescue StandardError => e
               500
             end
    p "#{status}: #{u}"
    {status: status}
  end
end
