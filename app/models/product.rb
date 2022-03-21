class Product < ApplicationRecord
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  # default case sensitive doesn't work
  validates :title,
            uniqueness: {
              case_sensitive: true
            },
            length: {
              minimum: 3
            },
            format: {
              with: /\A([A-Z]|\d)/,
              message:
                'must begin with first letter Uppercase or Digital number'
            }

  # use the allow_blank option to avoid getting multiple error messages when the field is blank.
  validates :image_url,
            allow_blank: true,
            format: {
              with: /\.(gif|jpg|png|jpeg)\z/i,
              message: 'must be a URL for GIF, JPG or PNG image.'
            }

  private

  def ensure_not_referenced_by_any_line_item
    return if line_items.empty?
    errors.add(:base, 'Line Items present')
    throw :abort
  end
end
