class User < ApplicationRecord
  has_many :meals
  has_many :bookings
  validates :first_name, :last_name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def total_pending
    total = 0
    meals.each do |meal|
      total += meal.pending_bookings
    end
    total
  end
end
