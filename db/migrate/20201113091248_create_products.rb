class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.text :description
      t.string :name
      t.decimal :price
      t.references :developer, null: false, foreign_key: true
      t.references :publisher, null: false, foreign_key: true
      t.datetime :release_date
      t.string :status

      t.timestamps
    end
  end
end
