class BookingsController < ApplicationController
  def new
    @meal = Meal.find(params[:meal_id])
    @booking = Booking.new
    # render 'bookings/new.html.erb'
  end

  def create
    @booking.user = current_user
    # need to differentiate host user and booking user
    @booking = Booking.new(booking_params)
    @meal = Meal.find(params[:meal_id])
    @booking.meal = @meal
    # @booking.save # => true/false
    if @booking.save
      redirect_to meal_path(@meal)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :size)
  end
end

# @meal.user = current_user
