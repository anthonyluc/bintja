class QuantitiesController < ApplicationController
    before_action :quantities_params, only: [:update]
    before_action :set_quantity, only: [:destroy]

    def shopping_list
        recipes = Recipe.where(user: current_user)
        @shopping_list = ShoppingList.where(user: current_user).first

        @quantities_tab = []
        recipes.each do |r|
          quantities = Quantity.includes(:ingredient).where(recipe: r, add_shopping_list: true)
          quantities.each do |q|
            @quantities_tab << [q.ingredient.name.downcase , q.quantity, q.unity, r.name, YouTubeAddy.extract_video_id(r.url_video)]
          end
        end
  
        @quantities_tab = Kaminari.paginate_array(@quantities_tab).page(params[:page]).per(25)

        authorize @shopping_list
    end

    def update
      if params[:recipe] != nil
        yt_video_id = YouTubeAddy.extract_video_id("https://www.youtube.com/watch?v=#{params[:id]}")
        if yt_video_id != nil
          recipe = Recipe.includes(:ingredients).where(user: current_user, url_video: "https://www.youtube.com/watch?v=#{yt_video_id}").first
          # MAJ des quantités
          recipe.update(quantities_params)
          authorize recipe
        end
      end
    end

    def destroy
      if @quantity != nil
        authorize @quantity
        @quantity.destroy 
      end
    end

    private

    def quantities_params
      if params[:recipe] != nil
        params.require(:recipe).permit(quantities_attributes: [:id, :quantity, :unity, :add_shopping_list, ingredient_attributes: [:id, :name]])
      end
    end

    def set_quantity
      @yt_video_id = YouTubeAddy.extract_video_id("https://www.youtube.com/watch?v=#{params[:recipe_id]}")
      @recipe = Recipe.where(user: current_user, url_video: "https://www.youtube.com/watch?v=#{@yt_video_id}").first
      @quantity = Quantity.where(recipe: @recipe, id: params[:id]).first
    end
end
