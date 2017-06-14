class User < ApplicationRecord
  has_many :requests, dependent: :destroy
  has_many :comments
  has_many :ratings
  has_many :orders, dependent: :destroy

  attr_accessor :remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name , presence: true,
    length: {maximum: Settings.user.name_size_max}
  validates :email, presence: true, length: {maximum: Settings.user.email_length},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.user.password_min}, allow_nil: true

  has_secure_password

  scope :search, -> input {where "name LIKE '%#{input}%' OR email LIKE '%#{input}%'"}

  class << self
    def digest string
    cost = ActiveModel::SecurePassword.min_cost ?
      BCrypt::Engine::MIN_COST: BCrypt::Engine.cost
    BCrypt::Password.create string, cost: cost
  end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update_attributes remember_digest: nil
  end

  def is_user? user
    self == user
  end

  def rated_product product_id
    ratings.find_by product_id: product_id
  end

  def rating_point_rated_product product_id
    product = rated_product product_id
    product ? product.rating_point : 0
  end

  def id_rated_product product_id
    product = rated_product product_id
    product ? product.id : 0
  end

  private

  def downcase_email
    email.downcase!
  end
end
