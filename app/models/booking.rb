class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :meal
  has_one :rating
  validates :date, :price, presence: true
  enum :status, { pending: 0, confirmed: 1, rejected: 2 }
end
