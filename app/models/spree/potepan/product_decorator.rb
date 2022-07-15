module Potepan::ProductDecorator
  Spree::Product.class_eval do
    def related_products
      Spree::Product.
        distinct.
        in_taxons(taxons).
        where.not(id: id).
        limit(4).
        includes(master: [:default_price, images: [attachment_attachment: :blob]])
    end
  end
end
