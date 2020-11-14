class Product < ApplicationRecord
  belongs_to :developer
  belongs_to :publisher

  has_many :product_orders
  has_many :orders, through: :product_orders

  has_many :genre_products
  has_many :genres, through: :genre_products

  validates :name, uniqueness: true
  validates :name, presence: true

  has_one_attached :avatar
end
