require 'rails_helper'

RSpec.describe Potepan::ProductDecorator, type: :model do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon) { create(:taxon, taxonomy: taxonomy) }
  let(:product) { create(:product, taxons: [taxon]) }
  let!(:related_product) { create_list(:product, 4, taxons: [taxon]) }

  describe "related_product" do
    it "関連する商品を取得すること" do
      expect(product.related_products).to eq related_product
    end

    it "商品詳細ページの商品が関連商品として取得されないこと" do
      expect(product.related_products).not_to eq product
    end

    it "関連商品が重複しないこと" do
      expect(product.related_products).to eq related_product.uniq
    end
  end
end
