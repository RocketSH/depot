class AssociateCartsWithUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :carts, :user, null: true, index: { unique: true }, foreign_key: true
  end
end
