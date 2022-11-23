class MealsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @meals = policy_scope(Meal)
  end

  def show
    @meal = Meal.find(params[:id])
    authorize @meal
  end

  def new
    @meal = Meal.new
    authorize @meal
  end

  def create
    @meal = Meal.new(meal_params)
    # @meal.user_id = current_user.id
    @meal.user = current_user
    authorize @meal
    if @meal.save
      redirect_to meal_path(@meal), notice: "Meal was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def my_meals
    @meals = current_user.meals
    authorize Meal
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :description, :min_size, :max_size, :price, :category, :location)
  end
end
