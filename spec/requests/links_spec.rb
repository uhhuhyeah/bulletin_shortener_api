require 'rails_helper'

RSpec.describe "Links", type: :request do
  let(:headers) { { "ACCEPT" => "application/json" } }
  let(:url) { 'http://example.com/something/very/long/to/share' }

  describe "POST /create" do
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

  describe "GET /show" do
    let!(:link) { Link.create(url: url) }

    context 'with SUCCESS' do
      it 'should redirect to the URL' do
        get "/s/#{link.slug}", :headers => headers
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to link.url
      end
    end

    context 'with FAILURE' do 
      it 'should return 404 if link is not found' do
        get "/s/not_a_real_slug", :headers => headers

        expect(response.content_type).to match("application/json")
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "GET /index" do
    let!(:link_1) { Link.create(url: url) }
    let!(:link_2) { Link.create(url: url + '/2') }
    let!(:link_3) { Link.create(url: url + '/3') }

    it 'should return a list of all links' do
      get "/links", :headers => headers

      expect(response.content_type).to match("application/json")
      json_response = JSON.parse(response.body)

      expect(json_response.size).to eq 3
      expect(json_response.first).to_not have_key('id')
      expect(json_response.first).to have_key('url')
      expect(json_response.first).to have_key('slug')
      expect(json_response.first).to have_key('time_since_creation')
    end
  end
end
