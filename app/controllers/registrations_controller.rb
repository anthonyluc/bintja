class RegistrationsController < Devise::RegistrationsController

    def edit
        @social_networks = SocialNetwork.where(user: current_user).first
        super
    end

    protected

    def after_update_path_for(resource)
        edit_user_registration_path
    end
end