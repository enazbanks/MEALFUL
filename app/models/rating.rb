class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :booking

  validates :value, presence: true
  validates :value, inclusion: { in: [0, 1, 2, 3, 4, 5], allow_nill: false }
end
