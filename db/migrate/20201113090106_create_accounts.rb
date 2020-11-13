class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :user_name
      t.string :password
      t.string :default_shipping_address
      t.string :fullname
      t.string :email
      t.string :billing_address
      t.integer :phone
      t.references :province, null: false, foreign_key: true

      t.timestamps
    end
  end
end
