class RegistrationsController < Devise::RegistrationsController

    def edit
        @social_networks = SocialNetwork.where(user: current_user).first
        super
    end

    def destroy
        reviews = Review.where(user: current_user)
        followers = Follower.where(follower_id: current_user)
        followeds = Follower.where(followed_id: current_user)
        reviews.each do |r|
            r.update(user_id: 1)
        end
        followers.each do |f|
            f.destroy
        end
        followeds.each do |f|
            f.destroy
        end
        super
    end

    protected

    def after_update_path_for(resource)
        edit_user_registration_path
    end
end