require 'rails_helper'

RSpec.describe "Products", type: :system do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon_1) { create(:taxon, taxonomy: taxonomy) }
  let(:taxon_2) { create(:taxon, taxonomy: taxonomy) }
  let(:product) { create(:product, taxons: [taxon_1]) }
  let(:image) { create(:image) }
  let(:image_1) { create(:image) }
  let(:image_2) { create(:image) }
  let(:image_3) { create(:image) }
  let(:image_4) { create(:image) }
  let(:image_5) { create(:image) }
  let!(:not_related_product) { create(:product, name: 'not_related_product', taxons: [taxon_2]) }
  let!(:related_product_1) { create(:product, name: 'related_product_1', taxons: [taxon_1]) }
  let!(:related_product_2) { create(:product, name: 'related_product_2', taxons: [taxon_1]) }
  let!(:related_product_3) { create(:product, name: 'related_product_3', taxons: [taxon_1]) }
  let!(:related_product_4) { create(:product, name: 'related_product_4', taxons: [taxon_1]) }

  before do
    product.images << image
    not_related_product.images << image_1
    related_product_1.images << image_2
    related_product_2.images << image_3
    related_product_3.images << image_4
    related_product_4.images << image_5
    visit potepan_product_path(product.id)
  end

  scenario "「一覧ページへ戻る」をクリックするとカテゴリーページへ移動すること" do
    click_link '一覧ページへ戻る'
    expect(current_path).to eq potepan_category_path(product.taxons.first.id)
  end

  describe "関連商品" do
    scenario "4つの関連商品が表示すること" do
      within('div.productsContent') do
        expect(page).to have_content related_product_1.name
        expect(page).to have_content related_product_2.name
        expect(page).to have_content related_product_3.name
        expect(page).to have_content related_product_4.name
      end
    end

    scenario "関連していない商品が表示しないこと" do
      within('div.productsContent') do
        expect(page).not_to have_content not_related_product.name
      end
    end

    scenario "関連する商品名をクリックするとその商品の詳細ページへ移動すること" do
      within('div.productsContent') do
        click_link related_product_1.name
      end
      expect(current_path).to eq potepan_product_path(related_product_1.id)
    end

    scenario "関連する商品価格をクリックするとその商品の詳細ページへ移動すること" do
      within('div.productsContent') do
        click_link related_product_1.display_price, match: :first
      end
      expect(current_path).to eq potepan_product_path(related_product_1.id)
    end
  end
end
