class RecipeRatesController < ApplicationController
    before_action :recipe_rate_params, only: :create

    def create
        video_id = @recipe_rate[:url][/recipes\/([\w\W]*)\?title/, 1]

        recipe_rate = RecipeRate.where(video_id: video_id, user: current_user).first
        

        if recipe_rate == nil
            recipe_rate = RecipeRate.new(stars: @recipe_rate[:stars], video_id: video_id, user: current_user)
            recipe_rate.save
        else
            RecipeRate.update(stars: @recipe_rate[:stars])
        end
        authorize recipe_rate
        redirect_to @recipe_rate[:url]
    end

    private

    def recipe_rate_params
        @recipe_rate = params.require(:recipe_rate).permit(:stars, :url)
    end
end
