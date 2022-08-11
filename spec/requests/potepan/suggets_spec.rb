require 'rails_helper'
require 'httpclient'
require 'webmock/rspec'
WebMock.allow_net_connect!

RSpec.describe "Potepan::Suggets", type: :request do
  describe "GET /potepan/suggets" do
    let(:url) { Rails.application.credentials.presite[:presite_url] }
    let(:key) { Rails.application.credentials.presite[:api_key] }
    let(:query) { { 'keyword': 'a', 'max_num': 5 } }
    let(:headers) { { 'Authorization': "Bearer #{key}" } }

    context "正常時" do
      it 'ステータスコード200と正確なsuggestが返ってくること' do
        WebMock.stub_request(:get, url).
          with(query: query, headers: headers).
          to_return(status: 200, body: ['apache', 'apache for women', 'apache for men'])
        client = HTTPClient.new
        response = client.get(url, query, headers)
        expect(response.status).to eq 200
        expect(response.body).to eq ['apache', 'apache for women', 'apache for men']
      end
    end

    context "異常時" do
      it 'ステータスコード500とエラーメッセージが返ってくること' do
        WebMock.stub_request(:get, url).
          with(query: query, headers: headers).
          to_return(status: 500, body: 'Internal Server Error')
        client = HTTPClient.new
        response = client.get(url, query, headers)
        expect(response.status).to eq 500
        expect(response.body).to eq 'Internal Server Error'
      end
    end
  end
end
