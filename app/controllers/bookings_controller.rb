class BookingsController < ApplicationController
  def index
    @bookings = policy_scope(Booking)
    @meals = Meal.all
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
    @booking.price = @meal.price * @booking.size
    @booking.user = current_user
    authorize @booking
    # @booking.save # => true/false
    if @booking.save
      redirect_to "/bookings"
      flash[:notice] = 'Successfully Booked'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH /bookings/:id
  def update
    @booking = Booking.find(params[:id])
    authorize @booking
    respond_to do |format|
      if @booking.update(booking_params)
        format.turbo_stream
        format.html { redirect_to bookings_path, status: :see_other, notice: "You've successfully updated your booking" }
      else
        format.html { redirect_to bookings_path, status: :see_other, alert: "Something went wrong while updating booking" }
      end
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :size, :status)
  end
end
