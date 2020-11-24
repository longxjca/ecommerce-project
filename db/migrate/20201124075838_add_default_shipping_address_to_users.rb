class AddDefaultShippingAddressToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :default_shipping_address, :string
  end
end
