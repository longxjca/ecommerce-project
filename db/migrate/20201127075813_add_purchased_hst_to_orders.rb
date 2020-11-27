class AddPurchasedHstToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :purchased_hst, :decimal
  end
end
