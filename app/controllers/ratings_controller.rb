class RatingsController < ApplicationController
  def new
    # TODO
    if @booking.confirmed?
      @booking = Booking.find(params[:booking_id])
      @rating = Rating.new
    else
      redirect_to meals_path(@meal), status: :see_other, notice: "Unable to create a review"
    end
  end

  def create
    @rating.user = current_user
    @rating = Rating.new(rating_params)
    @booking = Booking.find(params[:booking_id])
    @rating.booking = @booking
    if @rating.save
      redirect_to rating_path(@rating)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:value)
  end
end
