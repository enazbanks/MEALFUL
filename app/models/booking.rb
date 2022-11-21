class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :meal
  validates :date, :size, :price, presence: true
  enum :status, { pending: 0, confirmed: 1, rejected: 2}
end
