class UsersController < ApplicationController
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
          @follow = "Unfollow"
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
          user_recipe = Recipe.where(user: @user, url_video: @url_video).first
          if user_recipe.present?
              @quantities = Quantity.where(recipe_id: user_recipe.id)
              @recipe = user_recipe
              @user_recipe = Recipe.new

              authorize @quantities
              authorize @recipe
              authorize @user_recipe
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
end
