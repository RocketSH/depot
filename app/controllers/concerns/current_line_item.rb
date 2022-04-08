module CurrentLineItem
  def set_current_line_item
    if session[:line_item_id]
      @current_line_item ||= session[:line_item_id] && LineItem.find(session[:line_item_id])
    end
  end
end
