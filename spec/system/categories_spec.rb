require 'rails_helper'

RSpec.describe "Categories", type: :system do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon) { create(:taxon, taxonomy: taxonomy) }
  let(:taxons_root) { taxonomy.taxons.root }
  let(:product) { create(:product, taxons: [taxon]) }
  let(:image) { create(:image) }
  let!(:other_product) { create(:product) }

  before do
    product.images << image
    visit potepan_category_path(taxon.id)
  end

  describe "ユーザーがサイドバーを操作したとき" do
    scenario "カテゴリー名をクリックした際にカテゴリーページへ遷移すること" do
      click_link taxons_root.name
      expect(current_path).to eq potepan_category_path(taxon.id)
    end

    describe "CategoriesまたはBrandをクリックした後、" do
      scenario "カテゴリー一覧が表示されること" do
        find('ul.collapse').click
        expect(page).to have_content taxons_root.name
      end

      scenario "サイドバーに表示される個数と表示している商品数が一致していること" do
        within('h5.productName') do
          expect(page.all('.productBox').count).to eq taxons_root.all_products.count
        end
      end
    end

    scenario "カテゴリーに紐づく商品情報のみ表示されること" do
      click_link taxons_root.name
      within('div.productCaption') do
        expect(page).to have_content product.name
        expect(page).not_to have_content other_product.name
      end
    end
  end
end
