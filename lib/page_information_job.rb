class PageInformationJob < Motorurl::Job
  private

    def probe(url)
      domain         = UrlUtility.domain url
      crawl          = PageInformationWombat.new(url).crawl
      crawl.urls.select! { |link| UrlUtility.in_domain link.url, domain }
      crawl.urls.map     { |link| link.sha1 = UrlUtility.sha1 link.url }

      { stats: crawl }.merge(status url)
    end

    def status(url)
      { status: UrlUtility.status(url) }
    end

    def work(url)
      Hashie::Mash.new({
        sha1:     UrlUtility.sha1(url),
        seed_url: url,
        time:     Time.now.utc }.merge probe(url))
    end
end
