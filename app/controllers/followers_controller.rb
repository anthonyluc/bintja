class FollowersController < ApplicationController
    skip_after_action :verify_policy_scoped, only: [:index]

    def index
        # Follows
        follows = Follower.where(follower_id: current_user.id)
        @users = []
        @users_recipes = []
        if follows[0] != nil
          follows.each do |f|
            @users << User.find(f.followed_id)
            @users_recipes << Recipe.where(user: f.followed_id, show: true).count
          end
        end
        @users = Kaminari.paginate_array(@users).page(params[:p_users]).per(50)

        # authorize follows
  
        # Followers
        followers = Follower.where(followed_id: current_user.id)
        @followers = []
        @followers_recipes = []
        if followers[0] != nil
          followers.each do |f|
            @followers << User.find(f.follower_id)
            @followers_recipes << Recipe.where(user: f.follower_id, show: true).count
          end
        end
        @followers = Kaminari.paginate_array(@followers).page(params[:p_followers]).per(50)

        # authorize followers
    end

    def follow
      user = User.where(nickname: params[:user_id]).first
      follow = Follower.where(follower_id: current_user.id, followed_id: user.id).first
      
      # Si user follow déjà
      if follow != nil
        # On détruit
        authorize follow
        follow.destroy
      else 
        # Sinon on crée
        follow = Follower.create(follower_id: current_user.id, followed_id: user.id)
        authorize follow
      end
      redirect_to user_path(user.nickname)
    end
end
