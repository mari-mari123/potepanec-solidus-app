require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :request do
  describe "GET /potepan/categories" do
    it "works! (now write some real specs)" do
      get potepan_categories_index_path
      expect(response).to have_http_status(200)
    end
  end
end
