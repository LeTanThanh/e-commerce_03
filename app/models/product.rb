class Product < ApplicationRecord
  include ActionView::Helpers::TextHelper

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

  def category_name
    category ? category.name : I18n.t("products.show.unknow")
  end

  def available? order_quantity
    quantity >= order_quantity
  end

  def status order_quantity
    if available? order_quantity
      I18n.t("order_details.order_detail.available")
    else
      I18n.t("order_details.order_detail.not_available", product_quantity:
        pluralize(quantity, I18n.t("order_details.order_detail.product")))
    end
  end
end
