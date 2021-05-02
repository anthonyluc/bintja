class RecipeRatePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.user == user
  end
  
  def user_recipe_show?
    true
  end
end
