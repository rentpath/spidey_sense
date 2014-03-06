require 'mechanize'
require 'wombat'

class PageInformationWombat
  attr_reader :url

  def initialize(url)
  	@url = url
  end

  def crawl
    target = url

  	results = Wombat.crawl do 
  	  mechanize = Mechanize.new
  	  metadata  = mechanize.get target
  	  @metadata_dup.page(metadata)       # Copy the metadata into scope

  	  canonical    'xpath=/html/head//link[@rel="canonical"]/@href'
      description  'xpath=/html/head//meta[@name="description"]/@content' 
      headers      '.*', :headers

      urls        'xpath=/html/body//a', :iterator do
        link_text 'xpath=./text()'
        url       'xpath=./@href'
      end
  	end

    Hashie::Mash.new results
  end
end
