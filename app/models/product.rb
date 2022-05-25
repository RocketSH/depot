class Product < ApplicationRecord
  include ImageUploader::Attachment(:image)
  before_save :image_resize
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

  private

  def ensure_not_referenced_by_any_line_item
    return if line_items.empty?
    errors.add(:base, 'Line Items present')
    throw :abort
  end

  def image_resize
    self.image_derivatives!
  end
end
