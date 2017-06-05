class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: {case_sensitive: false},
    length: {maximum: Settings.category.name_max_length}

  has_many :products
end
