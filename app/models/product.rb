class Product < ApplicationRecord
  belongs_to :developer
  belongs_to :publisher
end
