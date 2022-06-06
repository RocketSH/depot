class Product < ApplicationRecord
  include ImageUploader::Attachment(:image)
  has_many :line_items
  has_many :orders, through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  # default case sensitive doesn't work
  validates :title,
            uniqueness: { case_sensitive: true },
            length: { minimum: 3 },
            format: { with: /\A([A-Z]|\d)/, message: 'must begin with first letter Uppercase or Digital number' }

  def file_remote_url=(url)
    return if url.blank?
    @file_remote_url = url
    file_attacher(cache: :cache_url)
    self.file = JSON.dump(
      id: url,
      storage: :cache_url,
      metadata: { filename: File.basename(URI(url).path) }
    )
  rescue URI::InvalidURIError, Down::Error
    file_attacher.errors << "invalid URL"
  end

  private

  def ensure_not_referenced_by_any_line_item
    return if line_items.empty?
    errors.add(:base, 'Line Items present')
    throw :abort
  end

  def image_resize
    self.image_validate
    self.image_derivatives!
  end
end
