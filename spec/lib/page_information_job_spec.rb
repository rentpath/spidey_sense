require 'spec_helper'

describe PageInformationJob do
  url = 'http://example.com/file.html'

  it_behaves_like 'a mocked connection', :get, 'perform_spec1.html', url do
    describe 'Instance Methods' do
      before(:each) do
        Motorurl.stub(:report)
      end

    	describe '#perform' do
    	  it 'returns a report' do
          result = subject.send :work, url
          stats  = result.o.stats
          expect(stats.canonical).to eq('http://example.com/page.html')
          expect(stats.description).to eq('Meta description')
          expect(stats.headers).to_not be_empty
          expect(stats.urls.all? { |u| u.url.match(/example.com\//) }).to be_true
          expect(stats.urls.all? { |u| u.sha1.present? }).to be_true
        end
    	end
    end
  end
end
