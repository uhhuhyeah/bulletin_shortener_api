require 'spec_helper'

RSpec.describe Link do

  describe '#create' do
    it 'should generate a unique slug given a URL to save' do
      long_url = 'http://example.com/something/very/long/to/share'
      
      expect {
        Link.create(url: long_url)
      }.to change(Link, :count).by(1)
    end
  end
end