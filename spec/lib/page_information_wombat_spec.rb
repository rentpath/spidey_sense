require 'spec_helper'

describe PageInformationWombat do
  url = 'http://dummy.org/file.html'

  it_behaves_like 'a mocked connection', :get, 'perform_spec1.html', url do
    describe 'Instance Methods' do
      describe '#crawl' do
        before(:all) do
          @results = described_class.new(url).crawl
        end

        describe 'returns a hash' do
          it 'containing the elements within the page' do
            expect(@results.slice(:canonical, :description, :headers, :urls).keys.compact.size).to eq(4)
          end

          it 'capturing page links' do
            links = @results.urls.map { |l| l.url }
            expect(links.size).to eq(4)
          end
        end
      end
    end
  end
end
