class UsersController < ApplicationController
    before_action :get_recipe_params, only: [:get_recipe]

    skip_before_action :authenticate_user!, only: [:show, :user_recipe_show]
    skip_after_action :verify_authorized, only: [:show]

    def show
        @user = User.find(params[:id])
      
        @social_networks = SocialNetwork.where(user: @user).first

        if params[:group].present?
          if params[:group][:id].present?
            @recipes = Recipe.where(user: @user, recipe_group_id: params[:group][:id], show: true)
            @group = RecipeGroup.where(user: @user, id: params[:group][:id]).first
          else
            @recipes = Recipe.where(user: @user, show: true)
          end
        else
          @recipes = Recipe.where(user: @user, show: true)
        end
        
        @groups = RecipeGroup.where(user: @user, private: false)
        
        # Follow button
        follow = Follower.where(follower_id: current_user, followed_id: @user).first
        if  follow != nil
          @follow = "You follow"
        else
          @follow = "Follow"
        end
        
        # .first.order(created_at: :desc)
        @selected = params[:group].blank? ? '' : params[:group][:id]
      
        @nb_follow = Follower.where(follower_id: @user.id).count
        @nb_followers = Follower.where(followed_id: @user.id).count
        @nb_recipes = Recipe.where(user: @user, show: true).count

        @recipes = Kaminari.paginate_array(@recipes).page(params[:page]).per(9)
    end

    def user_recipe_show
      yt_video_id = YouTubeAddy.extract_video_id("https://www.youtube.com/watch?v=#{params[:id]}")
      @url_video = "https://www.youtube.com/watch?v=#{yt_video_id}"
      @user = params[:user_id]
      if @user    
          user_recipe = Recipe.includes(:quantities).includes(:ingredients).where(user: @user, url_video: @url_video).first
          if user_recipe.present?
              @quantities = Quantity.where(recipe_id: user_recipe.id)
              @recipe = user_recipe
              @user_recipe = Recipe.new
              @add_reviews = Review.new
              @add_recipe_rate = RecipeRate.new
              @reviews = Review.includes(:user).where(video_id: yt_video_id).order(created_at: :desc)
              @recipe_rate = RecipeRate.where(video_id: yt_video_id).average(:stars).to_i
              @recipe_rate_count = RecipeRate.where(video_id: yt_video_id).count

              authorize @quantities
              authorize @recipe
              authorize @user_recipe
              authorize @reviews
              authorize @add_recipe_rate
              
              @reviews = Kaminari.paginate_array(@reviews).page(params[:page]).per(25)
          else
              redirect_to root_path
          end
      else
        redirect_to root_path
      end
    end

    def destroy_avatar
      current_user.avatar.purge
      authorize current_user
      redirect_to edit_user_registration_path
    end

    def get_recipe

      if @recipe.keys[0] != nil

        # Add Recipe
        recipe = Recipe.where(user: current_user, url_video: @recipe.values[0][:url]).first
        if recipe == nil
          recipe = Recipe.create(name: @recipe.keys[0], url_video: @recipe.values[0][:url], url_image: @recipe.values[0][:image], user: current_user)
        end

        # Copy Ingredients
        user_recipe = Recipe.where(user: params[:user_id], url_video: @recipe.values[0][:url]).first
        user_quantities = Quantity.where(recipe_id: user_recipe.id)
        user_quantities.each do |q|
          # On vérifie l'existence
          ingredient_exists = Quantity.where(recipe: recipe, ingredient: q.ingredient).first

          if ingredient_exists != nil
            ingredient_exists.update(quantity: q.quantity, unity: q.unity, recipe: recipe, ingredient: q.ingredient)
          else
            Quantity.create(quantity: q.quantity, unity: q.unity, recipe: recipe, ingredient: q.ingredient)
          end
        end

        authorize recipe
        authorize user_quantities
      else
        redirect_to root_path
      end
    end

    private

    def get_recipe_params
      params.require(:recipe).permit(:id, :user_id)

      yt_video_id = YouTubeAddy.extract_video_id("https://www.youtube.com/watch?v=#{params[:recipe][:id]}")
      load "#{Rails.root}/app/services/scrap_video_info.rb"
      @recipe = eval(ScrapVideoInfo.youtube(yt_video_id))
    end
end
