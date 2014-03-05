require 'spec_helper'

describe UrlUtility do 
	let(:domain)	{ 'example.org' }
	let(:fake)    { 'http://anywhere.org/example.org' }
	let(:fileurl) { 'file:///some/path/to/page.html' }
	let(:remote)  { 'http://www.anywhere.org/some/path/page.html' }
	let(:url) 		{ 'http://www.example.org/some/path/page.html' }

	describe 'Class Methods' do 
		describe '.domain extracts domain name' do 
			it { expect(described_class.domain fake).to eq('anywhere.org') }
			it { expect(described_class.domain remote).to eq('anywhere.org') }
			it { expect(described_class.domain url).to eq('example.org') }
		end

		describe '.in_domain' do 
			it 'returns true if URL contains domain' do 
				expect(described_class.in_domain url, domain).to be_true
			end

			it 'returns false if URL does not contain domain' do
				expect(described_class.in_domain remote, domain).to be_false
				expect(described_class.in_domain fake, domain).to be_false
			end

			it 'returns false if domain is nil' do
				expect(described_class.in_domain remote, nil).to be_false
			end

			it 'returns false if url is nil' do
				expect(described_class.in_domain nil, domain).to be_false
			end
		end

		describe '.normalize' do 
			it 'adds a trailing slash for non-file URLs if missing' do 
				expect(described_class.normalize url ).to match('/\Z') 
			end

			it 'does not add a trailing slash if present' do 
				expect(described_class.normalize(url + '/')).to match('html/\Z') 
			end

			it 'does not add a trailing slash for file:// URLs' do
				expect(described_class.normalize url ).to match('/\Z') 
			end
		end

		describe '.sha1' do 
			it { expect(described_class.sha1 url).to eq('22b47efe96db3b4ddcdb13250d7fb1198e1f06e3') }
		end

		describe '.status' do 
			it 'returns the status code of the page request' do
				WebMock.disable_net_connect!
				stub_request(:get, 'http://www.example.org/some/path/page.html').
          to_return(:status => 200, :body => '', :headers => {})
				expect(described_class.status url).to eq(200)
			end
		end
	end
end
