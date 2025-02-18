class StoreController < ApplicationController
  def index
    @products = Product.order(:title)

    # render inertia: 'Store/Index', props: { products: @products }
    render inertia: 'Store/Index', props: {
      products: @products.map do |product|
        serialize_product(product)
      end
    }
  end # END def index




  private

  def serialize_product(product)
    product.as_json(only: [
      :id, :title, :description, :price
    ]).tap do |hash|
      hash["image"] = {filename: product.image.filename, url: url_for(product.image)} if product.image.attached?
    end
  end


end # END class
