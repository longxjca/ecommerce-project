class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :account, null: false, foreign_key: true
      t.decimal :subtotal
      t.string :status
      t.string :shipping_address
      t.integer :stripe_intent_id

      t.timestamps
    end
  end
end
