require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "#show" do
    let(:product) {create(:product)}

    before do
      get potepan_product_path, params: {id: products_id}
    end

    it "正常にレスポンスを返すこと" do
      expect(response).to be_successful
    end
end
