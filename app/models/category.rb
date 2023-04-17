class Category < ApplicationRecord
  has_many :tests

  scope :order_category, -> { order(:title) }
end
