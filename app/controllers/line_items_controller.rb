class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: %i[ create ]
  before_action :set_line_item, only: %i[ show edit update destroy ]

  inertia_share flash: -> { flash.to_hash }

  # GET /line_items
  def index
    @line_items = LineItem.all
    render inertia: 'LineItem/Index', props: {
      line_items: @line_items.map do |line_item|
        serialize_line_item(line_item)
      end
    }
  end

  # GET /line_items/1
  def show
    render inertia: 'LineItem/Show', props: {
      line_item: serialize_line_item(@line_item)
    }
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
    render inertia: 'LineItem/New', props: {
      line_item: serialize_line_item(@line_item)
    }
  end

  # GET /line_items/1/edit
  def edit
    render inertia: 'LineItem/Edit', props: {
      line_item: serialize_line_item(@line_item)
    }
  end

  # POST /line_items
  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.line_items.build(product: product)

    if @line_item.save
      redirect_to @line_item.cart, notice: "Line item was successfully created."
    else
      redirect_to new_line_item_url, inertia: { errors: @line_item.errors }
    end
  end # END def create

  # PATCH/PUT /line_items/1
  def update
    if @line_item.update(line_item_params)
      redirect_to @line_item, notice: "Line item was successfully updated."
    else
      redirect_to edit_line_item_url(@line_item), inertia: { errors: @line_item.errors }
    end
  end

  # DELETE /line_items/1
  def destroy
    @line_item.destroy!
    redirect_to line_items_url, notice: "Line item was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def line_item_params
      params.require(:line_item).permit(:product_id, :cart_id)
    end

    def serialize_line_item(line_item)
      line_item.as_json(only: [
        :id, :product_id, :cart_id
      ])
    end

  def serialize_cart(cart)
    cart.as_json(only: [
      :id
    ])
  end

end
