class GenreProduct < ApplicationRecord
  belongs_to :genre
  belongs_to :product
end
