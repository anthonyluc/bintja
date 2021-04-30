class RecipesController < ApplicationController
    before_action :set_recipe, only: [:create]

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

    def create
        if @recipe.keys[0] != nil
          recipe = Recipe.create(name: @recipe.keys[0], url_video: @recipe.values[0][:url], url_image: @recipe.values[0][:image], user: current_user)
          yt_video_id = YouTubeAddy.extract_video_id(recipe.url_video)
          redirect_to recipe_path(yt_video_id, title: recipe.name)
          
          authorize recipe
        else
          redirect_to root_path
        end
    end

    private

    def set_recipe
        params.require(:recipe).permit(:id)
        yt_video_id = YouTubeAddy.extract_video_id("https://www.youtube.com/watch?v=#{params[:recipe][:id]}")
        load "#{Rails.root}/app/services/scrap_video_info.rb"
        @recipe = eval(ScrapVideoInfo.youtube(yt_video_id))
    end
end
