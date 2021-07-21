require 'spec_helper'

RSpec.describe Link do

  describe '#create' do
    let(:long_url) { 'http://example.com/something/very/long/to/share' }

    it 'should generate a unique slug given a URL to save' do
      expect {
        Link.create!(url: long_url)
      }.to change(Link, :count).by(1)
    end

    it 'should raise an error if a URL is not provided' do
      expect {
        Link.create!(url: nil)
      }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Url can't be blank")
    end

    context 'given an existing slug' do
      before do
        # Override the generate_slug method to return a static string, simulating
        # the unlikely possibility of generating a same slug as in use
        allow(SecureRandom).to receive(:alphanumeric).and_return('STATIC')
      end

      it 'should raise an error if the generated slug is not unique' do
        # Create first valid entry using static slug
        Link.create!(url: long_url + '/2') 

        expect {
          Link.create!(url: long_url)
        }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Slug has already been taken")
      end
    end
  end
end