class ShoppingListsController < ApplicationController
   before_action :shopping_list_params

    def update
        shopping_list = ShoppingList.where(user: current_user).first
        shopping_list.update(@shopping_list_params)
        authorize shopping_list
    end

    private

    def shopping_list_params
        @shopping_list_params = params.require(:shopping_list).permit(:shopping_note, :receive_email, :receive_email_day)
        @shopping_list_params[:receive_email_day] = transform_day(@shopping_list_params[:receive_email_day])
    end

    def transform_day(day)
        case day
        when '1'
            'monday'
        when '2'
            'tuesday'
        when '3'
            'wednesday'
        when '4'
            'thursday'
        when '5'
            'friday'
        when '6'
            'saturday'
        else
            'sunday'
        end
    end
end





