require 'httpclient'

class Potepan::SuggestsController < ApplicationController
  def suggest
    url = Rails.application.credentials.presite[:presite_url]
    key = Rails.application.credentials.presite[:api_key]
    header = { 'Authorization': "Bearer #{key}" }
    client = HTTPClient.new
    if params[:keyword].present?
      query = { 'keyword': params[:keyword], 'max_num': params[:max_num] }
      response = client.get(url, query, header)
      result = JSON.parse(response.body)
      if response.status == 200
        render status: 200, json: result
      else
        render status: response.status, json: response.body
      end
    else
      render status: 200, json: {}
    end
  end
end
