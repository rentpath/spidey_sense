require 'spec_helper'

module DukeOfUrl
  describe Normalizer do
    describe 'Alphabetizes URL parameters' do
      it 'works with homogeneous capitalization of param names' do
        url = 'example.com?z=26&a=1'
        expect(described_class.normalize url).to include('?a=1&z=26')
      end

      it 'works with heterogeneous capitalization of param names' do
        url = 'example.com?Z=26&a=1&Y=25'
        expect(described_class.normalize url).to include('Y=25&Z=26&a=1')
      end

      it 'works if trailing characters are /?' do
        url = 'example.com/?Z=26&a=1&Y=25'
        expect(described_class.normalize url).to include('Y=25&Z=26&a=1')
        expect(described_class.normalize url).to_not include('/?')
      end
    end

    describe 'Downcases domain name portion of URL' do
      let(:url) { 'ExAMpLe.oRg'}

      it { expect(described_class.normalize url).to eq('http://example.org/') }
    end

    describe 'Does not downcase path elements in URL' do
      let(:url) { 'ExAMpLe.oRg/A/b/C'}

      it { expect(described_class.normalize url).to eq('http://example.org/A/b/C') }
    end

    describe 'Performs NOP if' do
      it 'URL is nil' do
        expect(described_class.normalize nil).to be_nil
      end

      it 'URL is blank' do
        expect(described_class.normalize '').to eq('')
      end
    end
  end
end
