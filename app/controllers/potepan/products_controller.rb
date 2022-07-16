class Potepan::ProductsController < ApplicationController
  MAX_PRODUCTS = 4
  def show
    @product = Spree::Product.find(params[:id])
    @images = @product.images.includes(attachment_attachment: [:blob])
    @related_products = @product.related_products.
      includes(master: [:default_price, images: [attachment_attachment: :blob]]).
      limit(MAX_PRODUCTS)
  end
end
