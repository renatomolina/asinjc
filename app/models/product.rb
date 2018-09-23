class Product < ApplicationRecord
  validates :asin, presence: true
  validates :asin, uniqueness: true
end
