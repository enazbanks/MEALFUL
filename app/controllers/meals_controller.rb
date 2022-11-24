class MealsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :find_meal, only: [:show, :edit, :destroy, :update, :read]

  def index
    @meals = policy_scope(Meal)
    if params[:query].present?
      sql_query = "name ILIKE :query OR location ILIKE :query"
      @meals = Meal.where(sql_query, query: "%#{params[:query]}%")
    else
      @meals
    end
  end

  def show
    authorize @meal
  end

  def new
    @meal = Meal.new
    authorize @meal
  end

  def destroy
    authorize @meal
    @meal.delete
    redirect_to meals_path
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

  def edit
    authorize @meal
  end

  def update
    @meal.update(meal_params)
    redirect_to meal_path(@meal), status: :see_other
  end

  private
  def find_meal
    @meal = Meal.find(params[:id])
  end

  def meal_params
    params.require(:meal).permit(:name, :description, :min_size, :max_size, :price, :category, :location, :photo)
  end
end
