class RecipesController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index, :show]
    skip_after_action :verify_authorized, :verify_policy_scoped, only: [:index, :show]

    def index 
        load "#{Rails.root}/app/services/scrap_videos.rb"
        @recipes_search = (params[:search][:query]).parameterize
        recipes = ScrapVideos.youtube(@recipes_search)
        @recipes = eval(recipes)
    end

    def show
        @yt_video_id = YouTubeAddy.extract_video_id("https://www.youtube.com/watch?v=#{params[:id]}")
        @url_video = "https://www.youtube.com/watch?v=#{@yt_video_id}"
        @user = current_user
        if @user    
            user_recipe = Recipe.where(user: @user, url_video: @url_video).first
            if user_recipe.present?
                @bt_add_recipe = "added"
                @quantities = Quantity.where(recipe_id: user_recipe.id)
                
                @add_ingredient = Ingredient.new
                @add_quantity = Quantity.new
                @recipe = user_recipe
    
              # group
              @groups = policy_scope(RecipeGroup).order(created_at: :desc)
              @selected = user_recipe.recipe_group_id
    
            else
                @bt_add_recipe = 'to_add'
                @user_recipe = Recipe.new
            end
        else
            @bt_add_recipe  = "Add to my recipes"
        end
    end
end
