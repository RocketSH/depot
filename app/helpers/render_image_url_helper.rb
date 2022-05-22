module RenderImageUrlHelper
  def render_if_thumbnail(product)
    image_tag(product.image_data? ? product.image_url(:thumbnail) : '')
  end

  def render_if_profile(product)
    image_tag(product.image_data? ? product.image_url(:profile) : '')
  end

  def render_if_display(product)
    image_tag(product.image_data? ? product.image_url(:display) : '')
  end
end
