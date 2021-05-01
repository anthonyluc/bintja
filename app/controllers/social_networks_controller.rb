class SocialNetworksController < ApplicationController
    before_action :social_networks_params, only: [:update]

    def update
        social_networks = SocialNetwork.where(user: current_user).first
        social_networks.update(social_networks_params)

        authorize social_networks
        redirect_to edit_user_registration_path
    end

    private

    def social_networks_params
        params.require(:social_network).permit(:url_youtube, :url_instagram, :url_facebook, :url_website)
    end
end