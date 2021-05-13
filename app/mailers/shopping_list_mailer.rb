class ShoppingListMailer < ApplicationMailer
    include Rails.application.routes.url_helpers
    
    def send_shopping_list(user, shopping_note)
        @user = user
        @shopping_note = shopping_note
        
        recipes = Recipe.joins(:quantities).where(user: @user.id, quantities: {add_shopping_list: true}).distinct
        @quantities_tab = []

        recipes.each do |r|
            quantities = Quantity.includes(:ingredient).where(recipe: r)
            quantities.each do |q|
                @quantities_tab << [q.ingredient.name.downcase , q.quantity, q.unity, q.recipe.name, YouTubeAddy.extract_video_id(q.recipe.url_video)]
            end
        end

        mail(to: @user.email, subject: "Your shopping list to buy")
    end
end