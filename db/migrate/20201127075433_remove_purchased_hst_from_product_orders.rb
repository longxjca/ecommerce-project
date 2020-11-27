class RemovePurchasedHstFromProductOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :product_orders, :purchased_hst, :decimal
  end
end
