require 'spec_helper'

describe PageInformationWombat do
  before(:all) do 
    WebMock.disable_net_connect!
  end

  describe 'Instance Methods' do 
    before(:all) do 
      directory = File.join(Rails.root, 'spec/fixtures/files') 
      contents  = IO.read File.join(directory, 'perform_spec1.html')
      headers   = { 'Content-Type' => 'text/html' } 

      stub_request(:get, "http://dummy.org/file.html"). 
        to_return(status: 200, body: contents, headers: headers)
    end

    describe '#crawl' do 
      before(:all) do 
        @results = described_class.new('http://dummy.org/file.html').crawl
      end

      describe 'returns a hash' do
        it 'containing the elements within the page' do 
          expect(@results.slice(:canonical, :description, :headers, :links).keys.compact.size).to eq(4)
        end

        it 'capturing page links' do 
          links = @results.links.map { |l| l.url }
          expect(links.size).to eq(4)
        end
      end
    end
  end
end
