class Publisher < ApplicationRecord
  has_many :products

  validates :name, uniqueness: true
  validates :name, presence: true
end
