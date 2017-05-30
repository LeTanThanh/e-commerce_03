class User < ApplicationRecord
  has_many :requests
  has_many :comments
  has_many :ratings
  has_many :orders, dependent: :destroy

  has_secure_password
end
