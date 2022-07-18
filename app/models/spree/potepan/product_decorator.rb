module Potepan::ProductDecorator
  Spree::Product.class_eval do
    def related_products
      Spree::Product.
        distinct.
        in_taxons(taxons).
        where.not(id: id)
    end
  end
end
