require 'rails_helper'

RSpec.describe "Products", type: :system do
  let(:taxon) { create(:taxon) }
  let(:product) { create(:product, taxons: [taxon]) }
  let(:image) { create(:image) }

  before do
    product.images << image
    visit potepan_product_path(product.id)
  end

  scenario "「一覧ページへ戻る」をクリックするとカテゴリーページへ移動すること" do
    click_link '一覧ページへ戻る'
    expect(current_path).to eq potepan_category_path(product.taxons.first.id)
  end
end
