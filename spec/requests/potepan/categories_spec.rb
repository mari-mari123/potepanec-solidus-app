require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :request do
  describe "#show" do
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon]) }
    let(:image) { create(:image) }

    before do
      product.images << image
      get potepan_category_path(taxon.id)
    end

    it "正常にレスポンスを返すこと" do
      expect(response).to be_successful
    end

    describe "カテゴリー別商品情報" do
      it "商品名が含まれること" do
        expect(response.body).to include product.name
      end
      it "商品の値段が含まれること" do
        expect(response.body).to include product.display_price.to_s
      end
      it "左サイドバーにカテゴリー名が含まれること" do
        expect(response.body).to include taxonomy.name
        expect(response.body).to include taxon.name
      end
    end
  end
end
