module CurrentCart
  # Making the below method as private, prevents Rails from ever
  # making it available as an action on the controller.
  private
  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

end # END module