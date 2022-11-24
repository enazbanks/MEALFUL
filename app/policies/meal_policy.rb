class MealPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
      # scope.where(user: user) # If users can only see their meals
      # scope.where("name LIKE 't%'") # If users can only see meals starting with `t
    end
  end

  def booking?
    record.user == user
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  def my_meals?
    true
  end
end
