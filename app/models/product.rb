class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: {case_sensitive: false},
    length: {maximum: Settings.product.maximum_name_length}
  validates :price, numericality: {only_integer: true,
    greater_than_or_equal_to: Settings.product.min_price}
  validates :rating_point,
    numericality: {greater_than_or_equal_to: Settings.product.min_rating_point,
      less_than_or_equal_to: Settings.product.max_rating_point}
  validates :description, presence: true,
    length: {maximum: Settings.product.maximum_description_length}
  validates :quantity, presence: true, numericality: {only_integer: true,
    greater_than_or_equal_to: Settings.product.min_quantity}
  validates :picture, presence: true

  mount_uploader :picture, ImageUploader

  scope :hot_trend, -> do
    joins("INNER JOIN order_details ON products.id = order_details.product_id")
      .where("order_details.created_at >= :time",
        time: Settings.product.hot_trend_duration.weeks.ago)
      .group("products.id")
      .order("count(*) DESC")
      .limit(Settings.product.limit_hot_trend_product)
  end

  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :order_details
end
