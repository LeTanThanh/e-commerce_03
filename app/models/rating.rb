class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :rating_point, presence: true,
    numericality: {greater_than_or_equal_to: Settings.rating.min_rating_point,
      less_than_or_equal_to: Settings.rating.max_rating_point}

  after_save :update_product_rating

  private

  def update_product_rating
    rating_count = product.ratings.size
    total_rating_point = product.ratings.sum :rating_point
    rating_point = (1.0 * total_rating_point / rating_count).round 2
    product.update_attributes rating_point: rating_point
  end
end
