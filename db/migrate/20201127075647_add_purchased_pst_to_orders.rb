class AddPurchasedPstToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :purchased_pst, :decimal
  end
end
