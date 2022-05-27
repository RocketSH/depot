class AssociateUserToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :user, null: false, foreign_key: true
    change_column_null :orders, :name, false
    change_column_null :orders, :address, false
    change_column_null :orders, :email, false
    change_column_null :orders, :pay_type, false
  end
end
