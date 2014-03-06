require 'spec_helper'

describe PageInformationJob do 
  before(:all) do 
    directory = File.join(Rails.root, 'spec/fixtures/files') 
    contents  = IO.read File.join(directory, 'perform_spec1.html')
    headers   = { 'Content-Type' => 'text/html' } 

    stub_request(:get, 'http://example.com/file.html'). 
      to_return(status: 200, body: contents, headers: headers)
  end

  describe 'Instance Methods' do
    before(:each) do 
      Motorurl.stub(:report) 
    end

  	describe '#perform' do 
  	  it 'returns a report' do 
        result = subject.send :work, 'http://example.com/file.html'
        stats  = result.stats
        expect(stats.canonical).to eq('http://example.com/page.html')
        expect(stats.description).to eq('Meta description')
        expect(stats.headers).to_not be_empty
        expect(stats.urls.all? { |u| u.url.match(/example.com\//) }).to be_true
        expect(stats.urls.all? { |u| u.sha1.present? }).to be_true
      end
  	end
  end
end
