class ShoppingListPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    record.user == user
  end

  def shopping_list?
    record.user == user
  end
end
