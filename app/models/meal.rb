class Meal < ApplicationRecord
  belongs_to :user

  validates :name, :description, :size, :price, :category, :location, presence: true
end
