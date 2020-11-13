class Genre < ApplicationRecord
  has_many :genre_products
  has_many :products, through: :genre_products
end
