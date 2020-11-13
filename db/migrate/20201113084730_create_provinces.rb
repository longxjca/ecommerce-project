class CreateProvinces < ActiveRecord::Migration[6.0]
  def change
    create_table :provinces do |t|
      t.string :name
      t.decimal :pst
      t.decimal :gst
      t.string :hst
      t.string :decimal

      t.timestamps
    end
  end
end
