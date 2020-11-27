class Review < ApplicationRecord
  # creates a method for us on review instances like @review.product
  # returns the product instance with which that review belongs to
  belongs_to :product, dependent: :destroy

  validates :rating, presence: true, numericality: { 
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5
  }
end
