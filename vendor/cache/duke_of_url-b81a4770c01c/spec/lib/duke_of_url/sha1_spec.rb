require 'spec_helper'

module DukeOfUrl
  describe SHA1 do
    let(:url)       { 'http://www.example.org?a=1&z=26' }
    let(:hexdigest) { described_class.hexdigest(url) }
    let(:result)    { 'f7685ae49bb9f902e50acfe226df7165f589a8a8' }

    describe 'Computes a digest of a URL' do
      it 'in hexdigest form' do
        expect(hexdigest).to match(/^[0-9a-f]+$/)
      end

      it 'in 40 characters' do
        expect(hexdigest).to match(/^[0-9a-f]{40}$/)
      end

      it 'using proper algorithm' do
        expect(hexdigest).to eq(result)
      end
    end
  end
end
