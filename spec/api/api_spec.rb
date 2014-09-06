# encoding: utf-8
require 'rails_helper'

# This API should have coherent HTTP codes
# 200 OK - Everything worked as expected.
# 204 OK - Everything worked as expected. (No message Body)
# 400 Bad Request - Often missing a required parameter.
# 401 Unauthorized - No valid API key provided.
# 402 Request Failed - Parameters were valid but request failed.
# 404 Not Found - The requested item doesn't exist.
# 500, 502, 503, 504 Server errors - something went wrong on Praditus

describe 'API' do

  describe FOL::API::Root do
    include Rack::Test::Methods
    let(:browser){Rack::Test::Session.new(Rack::MockSession.new(described_class))}
    let(:api_version){'v1'}

    context "allow cross origin in API" do
      it "includes Access-Control-Allow-Origin in the response" do
        get "/api/ping", {}, "HTTP_ORIGIN" => "http://cors.example.com"
        expect(last_response.status).to eq(200)
        expect(last_response.headers['Access-Control-Allow-Origin']).to eq("http://cors.example.com")
      end
      it "includes Access-Control-Allow-Origin in errors" do
        get "/api/invalid", {}, "HTTP_ORIGIN" => "http://cors.example.com"
        expect(last_response.status).to eq(404)
        expect(last_response.headers['Access-Control-Allow-Origin']).to eq("http://cors.example.com")
      end
    end

    context 'not sign_in' do
      it "responds with json at the root, GET /" do
        browser.get("/")
        should_200({message: "Welcome to the API"})
        should_be_json
      end

      it "responds to GET /ping" do
        browser.get("/ping")
        should_200({message:'pong'})
        should_be_json
      end
    end

    context 'errors' do
      it "responds 404 to GET /an_incorrect_segment" do
        browser.get("/an_incorrect_segment")
        should_404
        should_be_json
      end
    end

    pending 'user sign_in' do
      before do
        login_as(Fabricate(:user), :scope => :user)
      end
      it "responds to GET /me" do
        browser.get("/me")
        should_201({})
        should_be_json
      end
      it 'can logout' do
        logout
        browser.get("/me")
        should_401({ message: '401 Unauthorized'})
        should_be_json
      end
    end

    pending 'admin sign_in' do
      before do
        login_as(Fabricate(:admin), :scope => :admin)
      end
    end

  end
end
