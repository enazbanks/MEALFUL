class RatingsController < ApplicationController
  def new
    # TODO
    @booking = Booking.find(params[:booking_id])
    if @booking.confirmed? && Date.today >= @booking.date
      @rating = Rating.new
      authorize @rating
    else
      redirect_to meals_path(@meal), status: :see_other, notice: "Unable to create a review"
    end
  end

  def create
    @rating.user = current_user
    @rating = Rating.new(rating_params)
    @booking = Booking.find(params[:booking_id])
    @rating.booking = @booking
    authorize @rating
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
