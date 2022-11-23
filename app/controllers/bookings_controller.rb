class BookingsController < ApplicationController
  def index
    @bookings = policy_scope(Booking)
  end

  def new
    @meal = Meal.find(params[:meal_id])
    @booking = Booking.new
    authorize @booking
    # render 'bookings/new.html.erb'
  end

  def create
    @booking = Booking.new(booking_params)
    @meal = Meal.find(params[:meal_id])
    @booking.meal = @meal
    @booking.price = @booking.meal.price * @booking.size
    @booking.user = current_user
    authorize @booking
    # @booking.save # => true/false
    if @booking.save
      redirect_to meal_path(@meal)
      flash[:notice] = 'Successfully Booked'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :size)
  end
end
