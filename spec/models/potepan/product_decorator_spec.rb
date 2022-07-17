require 'rails_helper'

RSpec.describe Potepan::ProductDecorator, type: :model do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon_1) { create(:taxon, taxonomy: taxonomy) }
  let(:taxon_2) { create(:taxon, taxonomy: taxonomy) }
  let(:taxon_3) { create(:taxon, taxonomy: taxonomy) }
  let(:product) { create(:product, taxons: [taxon_1, taxon_2]) }
  let!(:related_products) { create_list(:product, 5, taxons: [taxon_1, taxon_2]) }
  let!(:not_related_product) { create(:product, taxons: [taxon_3]) }

  describe "#related_products" do
    it "関連する商品を取得すること" do
      expect(product.related_products).to eq related_products
    end

    it "商品(product)が関連商品(related_products)として取得されないこと" do
      expect(product.related_products).not_to eq product
    end

    it "関連商品が重複しないこと" do
      expect(product.related_products).to eq related_products.uniq
    end

    it "関連しない商品が含まれないこと" do
      expect(product.related_products).not_to eq not_related_product
    end
  end
end
