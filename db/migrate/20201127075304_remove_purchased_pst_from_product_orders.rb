class RemovePurchasedPstFromProductOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :product_orders, :purchased_pst, :decimal
  end
end
