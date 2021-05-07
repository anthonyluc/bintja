class QuantityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def update?
    record.recipe.user == user
  end

  def destroy?
    record.recipe.user == user
  end

  def user_recipe_show?
    true
  end

  def get_recipe?
    true
  end
end
