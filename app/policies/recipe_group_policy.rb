class RecipeGroupPolicy < ApplicationPolicy
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
    record.user == user
  end

  def my_cookbook?
    true
  end

  def recipe_group?
    record.user == user
  end
end
