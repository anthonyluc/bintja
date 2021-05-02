class RecipesController < ApplicationController
    before_action :set_recipe, only: [:create]
    before_action :recipe_note_params, only: [:update]
    before_action :recipe_group_params, only: [:recipe_group]

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

    def update
        yt_video_id = YouTubeAddy.extract_video_id("https://www.youtube.com/watch?v=#{params[:id]}")
        if yt_video_id != nil
          user_recipe = Recipe.where(user: current_user, url_video: "https://www.youtube.com/watch?v=#{yt_video_id}").first
          user_recipe.update(@recipe_note_params)
          respond_to do |format|
            format.json { render json: { flash: "Update successfully." } }
          end

          authorize user_recipe
        end
    end

    def destroy
        @recipe = Recipe.where(user: current_user, url_video: "https://www.youtube.com/watch?v=#{params[:id]}")
        @recipe.first.destroy if @recipe.first != nil
        authorize @recipe
        redirect_to my_cookbook_path
    end

    def recipe_group
        yt_video_id = YouTubeAddy.extract_video_id("https://www.youtube.com/watch?v=#{params[:recipe_id]}")
        if yt_video_id != nil
          user_recipe = Recipe.where(user: current_user, url_video: "https://www.youtube.com/watch?v=#{yt_video_id}").first
    
          group = RecipeGroup.where(user: current_user, id: params[:recipe][:id]).first
          if group != nil
            user_recipe.update(recipe_group_id: group.id, show: group.toggle(:private).private)
          else
            user_recipe.update(recipe_group_id: nil, show: true)
          end

          authorize user_recipe
          authorize group if group != nil
        end
    end

    def my_cookbook

        @social_networks = SocialNetwork.where(user: current_user).first
        
        if params[:group].present?
          if params[:group][:id].present?
            @recipes = Recipe.where(user: current_user, recipe_group_id: params[:group][:id])
            @group = RecipeGroup.where(user: current_user, id: params[:group][:id]).first
            
            authorize @group
          else
            @recipes = policy_scope(Recipe).order(created_at: :desc)
          end
        else
          @recipes = policy_scope(Recipe).order(created_at: :desc)
        end
    
        @groups = policy_scope(RecipeGroup).order(created_at: :desc)
        @add_group = RecipeGroup.new
        @selected = params[:group].blank? ? '' : params[:group][:id]
        
        @nb_follow = Follower.where(follower_id: current_user.id).count
        @nb_followers = Follower.where(followed_id: current_user.id).count
        @nb_recipes = Recipe.where(user: current_user).count
    
        authorize @recipes
        authorize @groups
        authorize @add_group
    
        @recipes = Kaminari.paginate_array(@recipes).page(params[:page])
    end

    private

    def set_recipe
        params.require(:recipe).permit(:id)
        yt_video_id = YouTubeAddy.extract_video_id("https://www.youtube.com/watch?v=#{params[:recipe][:id]}")
        load "#{Rails.root}/app/services/scrap_video_info.rb"
        @recipe = eval(ScrapVideoInfo.youtube(yt_video_id))
    end

    def recipe_note_params
        @recipe_note_params = params.require(:recipe).permit(:note, :preparation_time, :cooking_time, :note_private)
        @recipe_note_params[:preparation_time] = Time.parse(@recipe_note_params[:preparation_time]).seconds_since_midnight
        @recipe_note_params[:cooking_time] = Time.parse(@recipe_note_params[:cooking_time]).seconds_since_midnight
    end

    def recipe_group_params
        params.require(:recipe).permit(:recipe, :recipe_id, :id)
    end
end
