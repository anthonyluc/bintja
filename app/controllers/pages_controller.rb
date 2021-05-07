class PagesController < ApplicationController
    skip_before_action :authenticate_user!, only: [:home]

    def home
      @users = User.order('random()').limit(8)
      @users_recipes = []
      @users.each do |u|
        @users_recipes << Recipe.where(user: u, show: true).count
      end

      @recipes = Recipe.last(9).reverse
    end
end