class RecipePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def create?
    record.user == user
  end

  def update?
    record.user == user
  end

  def destroy?
    true
  end

  def user_recipe_show?
    true
  end
  
  def my_cookbook?
    true
  end

  def recipe_group?
    record.user == user
  end

  def get_recipe?
    record.user == user
  end
end
