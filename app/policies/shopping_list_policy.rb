class ShoppingListPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def shopping_list?
    record.user_id == user.id
  end
end
