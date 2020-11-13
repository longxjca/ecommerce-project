class AddTrailerToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :trailer, :string
  end
end
