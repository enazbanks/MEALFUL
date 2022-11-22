class Meal < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :ratings, through: :bookings
  validates :name, :description, :min_size, :max_size, :price, :category, :location, presence: true
  def size
    "#{min_size} - #{max_size}"
  end

  def average_rating
    number = ratings.length
    if number.positive?
      total = 0
      ratings.each do |rating|
        total += rating.value
      end
      return total unless total.positive?

      return total / number
    end
    false
  end
end
