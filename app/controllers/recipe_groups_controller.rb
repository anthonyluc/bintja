class RecipeGroupsController < ApplicationController
    before_action :recipe_group_params, only: [:create]

    def create
        recipe_group = RecipeGroup.new(recipe_group_params)
        recipe_group.user = current_user
        if recipe_group.save
            authorize recipe_group
            redirect_to my_cookbook_path
        else
            render "recipes/my_cookbook"
        end
    end

    def update
        @group = RecipeGroup.where(user: current_user, id: params[:id]).first
        if @group != nil
            @group.toggle(:private).save
            @recipes = Recipe.where(user: current_user, recipe_group_id: @group.id)
            if @recipes.first != nil
                show = @group.toggle(:private).private
                @recipes.each do |r|
                    r.update(show: show)
                end

            end
        end
        authorize @group
        
        redirect_to my_cookbook_path('group[id]': @group.id)
    end

    def destroy
        @group = RecipeGroup.where(user: current_user, id: params[:id]).first
        if @group != nil
            @recipes = Recipe.where(user: current_user, recipe_group_id: @group.id)
            if @recipes.first != nil
                @recipes.each do |r|
                    r.update(recipe_group_id: nil, show: true)
                end
            end
            authorize @group
            @group.destroy
        end
        redirect_to my_cookbook_path, :params => ''
    end

    private

    def recipe_group_params
        params.require(:recipe_group).permit(:name)
    end
end
