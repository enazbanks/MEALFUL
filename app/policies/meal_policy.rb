class MealPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
      user.admin? ? scope.all : scope.where(user: user)
      # scope.where(user: user) # If users can only see their meals
      # scope.where("name LIKE 't%'") # If users can only see meals starting with `t
    end
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

end