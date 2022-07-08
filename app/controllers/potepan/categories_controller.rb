class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.all.includes(:root)
    @products = @taxon.all_products.includes(master: [:default_price, images: [attachment_attachment: :blob]])
  end
end
