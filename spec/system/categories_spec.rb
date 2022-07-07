require 'rails_helper'

RSpec.describe "Categories", type: :system do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon) { create(:taxon, taxonomy: taxonomy) }
  let(:product) { create(:product, taxons: [taxon]) }
  let(:image) { create(:image) }

  before do
    product.images << image
    visit potepan_category_path(taxon.id)
  end

  describe "ユーザーがサイドバーを操作したとき" do
    scenario "カテゴリー名をクリックした際にカテゴリーページへ遷移すること" do
      click_link taxonomy.taxons.root.name
      expect(current_path).to eq potepan_category_path(taxon.id)
    end
    scenario "サイドバーに表示される個数と表示している商品数が一致していること" do
      taxon = taxonomy.taxons.root
      find('ul.collapse').click
      expect(page).to have_content taxon.name
      expect(page).to have_content taxon.products.count
      within('div.productImage') do
        expect(page.all('.productBox').count).to eq taxon.products.all.count
      end
    end
  end
end
