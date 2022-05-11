module RenderImageUrlHelper
  def render_if_image_url(product)
    image_tag(product.image_url.present? ? product.image_url : product.image)
  end
end
