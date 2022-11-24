class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :meal
  has_one :meal_owner, through: :meal, source: :user
  has_one :rating
  validates :date, :price, presence: true
  enum :status, { pending: 0, confirmed: 1, rejected: 2 }

  def upcoming_confirmed?
    confirmed? && date > Date.today
  end
end
