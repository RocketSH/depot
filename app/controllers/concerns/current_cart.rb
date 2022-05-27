module CurrentCart
  private

  def set_cart
    if current_user.cart
      @cart = Cart.find_by(user_id: current_user.id)
    else
      @cart = Cart.create(user_id: current_user.id)
    end
  end
end
