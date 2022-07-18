require 'rails_helper'

RSpec.describe "Potepan::Product", type: :request do
  describe "#show" do
    let(:product) { create(:product, taxons: [taxon]) }
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon, taxonomy: taxonomy) }
    let(:related_product) { create(:product, name: 'related_product', taxons: [taxon]) }
    let(:image) { create(:image) }

    before do
      related_product.images << image
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

    describe "関連商品情報" do
      it "商品名が含まれていること" do
        expect(response.body).to include related_product.name
      end

      it "商品金額が含まれていること" do
        expect(response.body).to include related_product.display_price.to_s
      end
    end
  end
end
