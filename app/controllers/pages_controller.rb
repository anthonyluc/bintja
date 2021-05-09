class PagesController < ApplicationController
    skip_before_action :authenticate_user!, only: [:home, :cgu, :privacy_policy, :cookie_consent]

    def home
      @users = User.order('random()').limit(8)
      @users_recipes = []
      @users.each do |u|
        @users_recipes << Recipe.where(user: u, show: true).count
      end

      @recipes = Recipe.last(9).reverse
    end

    def cgu
    end

    def privacy_policy
    end

    def cookie_consent
    end
end