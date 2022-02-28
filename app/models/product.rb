class Product < ApplicationRecord
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01}
  # default case sensitive doesn't work
  validates :title, uniqueness: true, length: { minimum: 10 }
  # use the allow_blank option to avoid getting multiple error messages when the field is blank.
  validates :image_url, allow_blank: true, format: { with: %r{\.(gif|jpg|png|jpeg)\z}i,
  message: 'must be a URL for GIF, JPG or PNG image.'
  }

  private

    def ensure_not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, 'Line Items present')
        throw :abort
      end
    end
end