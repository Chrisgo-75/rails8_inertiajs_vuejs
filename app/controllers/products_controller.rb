class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  inertia_share flash: -> { flash.to_hash }

  # GET /products
  def index
    @products = Product.all
    render inertia: 'Product/Index', props: {
      products: @products.map do |product|
        serialize_product(product)
      end
    }
  end

  # GET /products/1
  def show
    render inertia: 'Product/Show', props: {
      product: serialize_product(@product)
    }
  end

  # GET /products/new
  def new
    @product = Product.new
    render inertia: 'Product/New', props: {
      product: serialize_product(@product)
    }
  end

  # GET /products/1/edit
  def edit
    render inertia: 'Product/Edit', props: {
      product: serialize_product(@product)
    }
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product, notice: "Product was successfully created."
    else
      redirect_to new_product_url, inertia: { errors: @product.errors }
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Product was successfully updated."
    else
      redirect_to edit_product_url(@product), inertia: { errors: @product.errors }
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy!
    redirect_to products_url, notice: "Product was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :description, :image, :price)
    end

    def serialize_product(product)
      product.as_json(only: [
        :id, :title, :description, :price
      ]).tap do |hash|
        hash["image"] = {filename: product.image.filename, url: url_for(product.image)} if product.image.attached?
      end
    end
end
