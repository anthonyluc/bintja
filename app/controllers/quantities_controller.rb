class QuantitiesController < ApplicationController
    before_action :quantities_params, only: [:update]
    before_action :set_quantity, only: [:destroy]
    
    skip_after_action :verify_authorized, only: [:update, :destroy]
    
    def shopping_list
        recipes = Recipe.joins(:quantities).where(user: current_user, quantities: {add_shopping_list: true}).distinct
        @shopping_list = ShoppingList.where(user: current_user).first
        @shopping_list.receive_email_day = transform_day(@shopping_list.receive_email_day)
        @quantities_tab = []
  
        recipes.each do |r|
           quantities = Quantity.includes(:ingredient).where(recipe: r)
           quantities.each do |q|
            @quantities_tab << [q.ingredient.name.downcase , q.quantity, q.unity, q.recipe.name, YouTubeAddy.extract_video_id(q.recipe.url_video)]
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
          
            authorize recipe if recipe.update(@quantities_params)
        end
      end
    end

    def destroy
      if @quantity != nil
        @quantity.destroy 
      end
    end

    private

    def quantities_params
      if params[:recipe] != nil
       @quantities_params = params.require(:recipe).permit(quantities_attributes: [:id, :quantity, :unity, :add_shopping_list, ingredient_attributes: [:id, :name]])
      end
    end

    def set_quantity
      @yt_video_id = YouTubeAddy.extract_video_id("https://www.youtube.com/watch?v=#{params[:recipe_id]}")
      @recipe = Recipe.where(user: current_user, url_video: "https://www.youtube.com/watch?v=#{@yt_video_id}").first
      @quantity = Quantity.where(recipe: @recipe, id: params[:id]).first
    end

    def transform_day(day)
      case day
      when 'monday'
          1
      when 'tuesday'
          2
      when 'wednesday'
          3
      when 'thursday'
          4
      when 'friday'
          5
      when 'saturday'
          6
      else
          7
      end
    end
end
