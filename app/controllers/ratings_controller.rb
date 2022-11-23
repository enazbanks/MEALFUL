class RatingsController < ApplicationController
  def new
    # TODO
    @booking = Booking.find(params[:booking_id])
      @rating = Rating.new
      authorize @rating
  end

  def create
    @rating = Rating.new(rating_params)
    @rating.user = current_user
    @booking = Booking.find(params[:booking_id])
    @rating.booking = @booking
    authorize @rating
    if @rating.save
      redirect_to meal_path(@booking.meal)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:value)
  end
end
