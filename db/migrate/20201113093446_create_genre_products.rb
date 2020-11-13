class CreateGenreProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :genre_products do |t|
      t.references :genre, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
