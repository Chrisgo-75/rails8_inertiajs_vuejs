class CartsController < ApplicationController
  before_action :set_cart, only: %i[ show edit update destroy ]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  inertia_share flash: -> { flash.to_hash }

  # GET /carts
  def index
    @carts = Cart.all
    render inertia: 'Cart/Index', props: {
      carts: @carts.map do |cart|
        serialize_cart(cart)
      end
    }
  end

  # GET /carts/1
  def show
    render inertia: 'Cart/Show', props: {
      cart: serialize_cart(@cart)
    }
  end

  # GET /carts/new
  def new
    @cart = Cart.new
    render inertia: 'Cart/New', props: {
      cart: serialize_cart(@cart)
    }
  end

  # GET /carts/1/edit
  def edit
    render inertia: 'Cart/Edit', props: {
      cart: serialize_cart(@cart)
    }
  end

  # POST /carts
  def create
    @cart = Cart.new(cart_params)

    if @cart.save
      redirect_to @cart, notice: "Cart was successfully created."
    else
      redirect_to new_cart_url, inertia: { errors: @cart.errors }
    end
  end

  # PATCH/PUT /carts/1
  def update
    if @cart.update(cart_params)
      redirect_to @cart, notice: "Cart was successfully updated."
    else
      redirect_to edit_cart_url(@cart), inertia: { errors: @cart.errors }
    end
  end

  # DELETE /carts/1
  def destroy
    @cart.destroy! if @cart.id == session[:cart_id]
    session[:cart_id] = nil

    flash[:notice] = "Your cart is currently empty."
    redirect_to store_index_path
  end

  private
  def invalid_cart
    Rails.logger.error("Attempt to access invalid cart #{params[:id]}")

    flash[:alert] = "Invalid cart"
    redirect_to store_index_url
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.fetch(:cart, {})
    end

    def serialize_cart(cart)
      cart.as_json(only: [
        :id
      ])
    end
end
