class MealsController < ApplicationController
  def index
    @meals = Meal.all
  end

  def show
    @meal = Meal.find(params[:id])
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(meal_params)
    # @meal.user_id = current_user.id
    @meal.user = current_user
    if @meal.save
      redirect_to meal_path(@meal), notice: "Meal was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :description, :min_size, :max_size, :price, :category, :location)
  end
end
