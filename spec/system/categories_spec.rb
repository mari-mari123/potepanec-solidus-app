require 'rails_helper'

RSpec.describe "Categories", type: :system do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon) { create(:taxon) }
  let(:product) { create(:product, taxons: [taxon]) }
  let(:image) { create(:image) }

  before do
    product.images << image
    visit potepan_category_path(taxon.id)
  end

  describe "ユーザーがサイドバーを操作したとき" do
    scenario "カテゴリー名をクリックした際にカテゴリーページへ遷移すること" do
      taxonomy.root.leaves.each do |taxon|
        click_link taxon.name
        expect(current_path).to eq potepan_category_path(taxon.id)
      end
    end
    scenario "サイドバーに表示される個数と表示している商品数が一致していること" do
      taxonomy.root.leaves.each do |taxon|
        expect(page).to have_content taxon.name
        expect(page).to have_content taxon.products.count
        expect(page.all('productBox').count).to eq taxon.products.count
      end
    end
  end
end
