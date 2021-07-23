require 'rails_helper'

RSpec.describe "Links", type: :request do

  describe "POST /create" do
    let(:headers) { { "ACCEPT" => "application/json" } }
    let(:url) { 'http://example.com/something/very/long/to/share' }

    context 'with SUCCESS' do
      it 'allows for a link to be created via JSON' do
        post "/links", :params => { :url => url }, :headers => headers

        expect(response.content_type).to match("application/json")
        expect(response).to have_http_status(:created)

        created_link = Link.last
        json_response = JSON.parse(response.body)

        expect(json_response['link']['id']).to eq created_link.id
        expect(json_response['link']['url']).to eq created_link.url
        expect(json_response['link']['slug']).to eq created_link.slug
      end

      context 'when submitted a URL we already have a link for' do
        let!(:first_link) { Link.create(url: url) }
        
        it 'should return the existing Link and not create a new one' do
          expect {
            post "/links", :params => { :url => url }, :headers => headers

            expect(response.content_type).to match("application/json")
            expect(response).to have_http_status(:created)
    
            created_link = Link.last
            json_response = JSON.parse(response.body)
    
            expect(json_response['link']['id']).to eq created_link.id
            expect(json_response['link']['url']).to eq created_link.url
            expect(json_response['link']['slug']).to eq created_link.slug
          }.to_not change(Link, :count)
        end
      end
    end

    context 'with FAILURE' do
      it 'should return an error status' do
        post "/links", :params => { :url => nil }, :headers => headers

        expect(response.content_type).to match("application/json")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
