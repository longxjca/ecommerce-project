class RemovePurchasedGstFromProductOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :product_orders, :purchased_gst, :decimal
  end
end
