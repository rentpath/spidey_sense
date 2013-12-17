require 'uri'
require "net/http"
require 'wombat'
require 'duke_of_url'

require 'pry'
require 'pry-nav'


class ScreamingFrog
  include Wombat::Crawler

  def self.name
    'Screaming Frog Sensor'
  end

  def self.process(u,p)
    results = {
      sensor: self.name,
      sha1: DukeOfUrl::SHA1.hexdigest(u),
      seed_url: u,
      time: Time.now.utc,
      stats: {},
      urls: []
    }

    crawl_results   = work(u,p)
    results[:stats] = build_stat_results(crawl_results)
    results[:urls]  = build_url_results(u, crawl_results)
    results.to_json
  end

  private

  def self.build_stat_results(crawl_results)
    {
      status: crawl_results[:status],
      canonical: crawl_results['canonical'],
      description: crawl_results['description']
    }
  end

  def self.build_url_results(u, crawl_results)
    return {} if crawl_results.nil? || crawl_results.empty?
    p crawl_results
    uri = URI(u);

    urls = {}
    unless crawl_results['links'].empty?
      p "doing something on #{crawl_results['links']}"
      n = 0;
      urls = crawl_results['links'].select! { |u|
        u if domain_url?(uri.host, u['url'])
      }.each { |u|
        if (++n < 10)
          u[:sha1] = DukeOfUrl::SHA1.hexdigest(u['url'])
          u[:stats] = recon(u['url'],'/')
        end
      }
    end
    urls
  end

  def self.domain_url?(host, u)
    return false if u.nil?
    u.match Regexp.new "^((http|https):\/\/)?#{host}\/"
  end

  def self.recon(u, p)
    payload = {}
    payload.merge!(url_status(u))

    if payload[:status] < 400
      stats = Wombat.crawl do
        base_url u
        path p

        canonical 'xpath=/html/head//link[@rel="canonical"]/@href'
        description 'xpath=/html/head//meta[@name="description"]/@content'
      end
      payload.merge!(stats)
    end

    payload
  end

   def self.extract_urls(u,p)
    Wombat.crawl do
      base_url u
      path p

      links 'xpath=/html/body//a', :iterator do
        link_text 'xpath=./text()'
        url 'xpath=./@href'
      end
    end
  end

  def self.url_status(u)
    status = begin
               url = URI.parse(u.end_with?('/') ? u : "#{u}/")
               req = Net::HTTP.new(url.host, url.port)
               res = req.request_head(url.path)
               p "#{res.code}: #{u}"
               res.code.to_i
             rescue StandardError => e
               500
             end
    {status: status}
  end

  def self.work(u, p)
    payload = {}
    payload.merge! self.recon(u,p)
    payload.merge! self.extract_urls(u,p) if (payload[:status] < 400)
    payload
  end
end
