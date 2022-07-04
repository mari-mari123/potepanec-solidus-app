require 'rails_helper'

RSpec.describe "Potepan::Product", type: :request do
  describe "#show" do
    let(:taxon) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon]) }

    before do
      get potepan_product_path(product.id)
    end

    it "正常にレスポンスを返すこと" do
      expect(response).to be_successful
    end

    describe "商品情報" do
      it "商品名が含まれていること" do
        expect(response.body).to include product.name
      end
      it "商品説明が含まれていること" do
        expect(response.body).to include product.description
      end
      it "商品金額が含まれていること" do
        expect(response.body).to include product.display_price.to_s
      end
    end
  end
end
