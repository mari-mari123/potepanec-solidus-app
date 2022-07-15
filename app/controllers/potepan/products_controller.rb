class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @images = @product.images.includes(attachment_attachment: [:blob])
    @related_products = @product.related_products
  end
end
