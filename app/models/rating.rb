class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :rating_point, presence: true,
    numericality: {greater_than_or_equal_to: Settings.rating.min_rating_point,
      less_than_or_equal_to: Settings.rating.max_rating_point}
end
