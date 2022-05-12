module RenderImageUrlHelper
  def render_if_thumbnail(product)
    image_tag(product.image_url.present? ? product.image_url : product.thumbnail)
  end

  def render_if_profile(product)
    image_tag(product.image_url.present? ? product.image_url : product.profile)
  end

  def render_if_display(product)
    image_tag(product.image_url.present? ? product.image_url : product.display)
  end
end
