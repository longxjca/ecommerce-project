class Account < ApplicationRecord
  belongs_to :province
  has_many :orders

  validates :user_name, uniqueness: true
  validates :user_name, presence: true
end
