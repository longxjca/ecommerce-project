class AddPurchasedGstToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :purchased_gst, :decimal
  end
end
