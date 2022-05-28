module RescueInvalidCart
  private

  def invaild_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to root_url, notice: 'Sorry, you are querying an invalid cart'
  end
end
