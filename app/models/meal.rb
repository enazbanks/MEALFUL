class Meal < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :bookings, dependent: :destroy
  has_many :ratings, through: :bookings
  validates :name, :description, :min_size, :max_size, :price, :category, :location, presence: true
  def size
    "#{min_size} - #{max_size}"
  end

  def pending_bookings
    total = 0
    bookings.each do |booking|
      total += 1 if booking.pending?
    end
    total
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

  include PgSearch::Model
  pg_search_scope :search_by_name_and_location,
    against: [ :name, :location ],
    using: {
      tsearch: { prefix: true }
    }
end
