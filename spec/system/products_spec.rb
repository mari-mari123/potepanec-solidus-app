require 'rails_helper'

RSpec.describe "Products", type: :system do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon1) { create(:taxon, taxonomy: taxonomy) }
  let(:taxon2) { create(:taxon, taxonomy: taxonomy) }
  let(:taxon3) { create(:taxon, taxonomy: taxonomy) }
  let(:product) { create(:product, taxons: [taxon1, taxon2]) }
  let(:image) { create(:image) }
  let(:not_related_product) { create(:product, name: 'not_related_product', taxons: [taxon3]) }
  let(:related_product_1) { create(:product, name: 'related_product_1', taxons: [taxon1, taxon2]) }
  let(:related_product_2) { create(:product, name: 'related_product_2', taxons: [taxon1, taxon2]) }
  let(:related_product_3) { create(:product, name: 'related_product_3', taxons: [taxon1, taxon2]) }
  let(:related_product_4) { create(:product, name: 'related_product_4', taxons: [taxon1, taxon2]) }
  let(:related_product_5) { create(:product, name: 'related_product_5', taxons: [taxon1]) }

  before do
    product.images << create(:image)
    not_related_product.images << create(:image)
    related_product_1.images << create(:image)
    related_product_2.images << create(:image)
    related_product_3.images << create(:image)
    related_product_4.images << create(:image)
    related_product_5.images << create(:image)
    visit potepan_product_path(product.id)
  end

  scenario "「一覧ページへ戻る」をクリックするとカテゴリーページへ移動すること" do
    click_link '一覧ページへ戻る'
    expect(current_path).to eq potepan_category_path(product.taxons.first.id)
  end

  describe "関連商品" do
    let(:products) { [related_product_1, related_product_2, related_product_3, related_product_4] }

    scenario "4つの関連商品が表示すること" do
      within('div.productsContent') do
        products.each.all? do |related_product|
          expect(page).to have_content related_product.name
        end
      end
    end

    scenario "5つ以上の関連商品がある場合、関連する商品が4つ表示されること" do
      within('div.productsContent') do
        expect(page).to have_selector '.productBox', count: 4
      end
    end

    scenario "関連していない商品が表示されないこと" do
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
