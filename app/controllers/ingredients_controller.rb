class IngredientsController < ApplicationController
    before_action :set_params, only: [:create]

    def create
        yt_video_id = YouTubeAddy.extract_video_id("https://www.youtube.com/watch?v=#{params[:ingredient][:video_id]}")
        if yt_video_id != nil
          @recipe = Recipe.where(user: current_user, url_video: "https://www.youtube.com/watch?v=#{yt_video_id}").first
          ingredient = Ingredient.where('lower(name) = ?', (params[:ingredient][:name]).downcase).first
  
          # On crée l'ingredient si on ne le trouve pas dans la base
          if ingredient == nil
            ingredient = Ingredient.create(name: params[:ingredient][:name])
            authorize ingredient
          end
          # On crée l'instance pour cette recette et cet ingredient
  
          # On vérifie l'existence
          quantity_exists = Quantity.where(recipe: @recipe, ingredient: ingredient).first
  
          if quantity_exists == nil
            quantity_exists = Quantity.create(quantity: params[:ingredient][:quantity][:quantity], unity: params[:ingredient][:quantity][:unity], recipe: @recipe, ingredient: ingredient)
          else
            quantity_exists.update(quantity: params[:ingredient][:quantity][:quantity], unity: params[:ingredient][:quantity][:unity], recipe: @recipe, ingredient: ingredient)
          end
  
          counter = Quantity.where(recipe_id: @recipe.id).count
          respond_to do |format|
            format.html
            format.json { render json: { added: {counter: counter-1, recipe: yt_video_id, quantity: {id: quantity_exists.id, quantity: quantity_exists.quantity, unity: quantity_exists.unity}, ingredient:  {id: ingredient.id, name: ingredient.name, calorie: ingredient.calorie} } } }
          end

          authorize quantity_exists
          
        else
          redirect_to root_path
        end
    end

    private

    def set_params
      params.require(:ingredient).permit(:video_id, :name, quantity: [:quantity, :unity])
    end
end
