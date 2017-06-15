class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: {case_sensitive: false},
    length: {maximum: Settings.category.name_max_length}

  has_many :products, dependent: :nullify

  scope :search, -> input do
    where "name LIKE '%#{input}%'"
  end
end
