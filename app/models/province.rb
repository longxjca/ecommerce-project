class Province < ApplicationRecord
  has_many :accounts

  validates :name, uniqueness: true
  validates :name, presence: true
end
