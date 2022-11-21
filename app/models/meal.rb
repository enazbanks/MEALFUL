class Meal < ApplicationRecord
  belongs_to :user
  has_many :bookings
  validates :name, :description, :min_size, :max_size, :price, :category, :location, presence: true
end
