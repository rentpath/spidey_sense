require 'uri'
require "net/http"
require 'wombat'
require 'duke_of_url'


class UrlStats
  include Wombat::Crawler

  def self.name
    'URL Stats Sensor'
  end

  def self.process(url, path = '/')
    results = {
      sensor: self.name,
      sha1: DukeOfUrl::SHA1.hexdigest(url),
      seed_url: url,
      time: Time.now.utc,
      stats: {},
      urls: []
    }

    crawl_results   = work(url, path)
    results[:stats] = build_stat_results(crawl_results)
    results[:urls]  = build_url_results(url, crawl_results)
    results
  end

  private

  def self.work(url, path)
    payload = {}
    payload.merge! self.get_stats(url, path)
    # payload.merge! self.extract_urls(url, path) if (payload[:status] < 400)
    payload
  end

  def self.get_stats(url, path)
    payload = {}
    payload.merge!(url_status(url))

    if payload[:status] < 400
      stats = Wombat.crawl do
        base_url url
        path path

        canonical 'xpath=/html/head//link[@rel="canonical"]/@href'
        description 'xpath=/html/head//meta[@name="description"]/@content'
      end
      payload.merge!(stats)
    end

    payload
  end

  def self.extract_urls(url, path)
    Wombat.crawl do
      base_url url
      path path

      links 'xpath=/html/body//a', :iterator do
        link_text 'xpath=./text()'
        url 'xpath=./@href'
      end
    end
  end

  def self.build_stat_results(crawl_results)
    {
      status: crawl_results[:status],
      canonical: crawl_results['canonical'],
      description: crawl_results['description']
    }
  end

  def self.build_url_results(url, crawl_results)
    return {} if crawl_results.nil? || crawl_results['links'].nil?

    urls = {}

    uri = URI(url);
    urls = crawl_results['links'].select! { |u|
      u if domain_url?(uri.host, u['url'])
    }.each { |u|
      u[:sha1] = DukeOfUrl::SHA1.hexdigest(u['url'])
      u[:stats] = get_stats(u['url'],'/')
    }

    urls
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
