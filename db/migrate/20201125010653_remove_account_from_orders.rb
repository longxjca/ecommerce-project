class RemoveAccountFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_reference :orders, :account, null: false, foreign_key: true
  end
end
