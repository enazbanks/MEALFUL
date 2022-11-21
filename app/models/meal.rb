class Meal < ApplicationRecord
  belongs_to :user
  has_many :bookings
  validates :name, :description, :size, :price, :category, :location, presence: true
end
