class ShoppingListsController < ApplicationController
   before_action :shopping_list_params

    def update
        shopping_list = ShoppingList.where(user: current_user).first
        shopping_list.update(shopping_list_params)
        authorize shopping_list
    end

    private

    def shopping_list_params
        params.require(:shopping_list).permit(:shopping_note)
    end

end
