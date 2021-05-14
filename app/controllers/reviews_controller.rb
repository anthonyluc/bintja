class ReviewsController < ApplicationController
    before_action :reviews_params, only: :create
    before_action :set_review, only: :destroy

    skip_after_action :verify_authorized, only: [:destroy]

    def create
        video_id = @reviews[:url][/recipes\/([\w\W]*)\?title/, 1]
        review = Review.new(comment: @reviews[:comment], video_id: video_id, user: current_user)
        authorize review
        if review.save
            respond_to do |format|
                format.html
                format.json { render json: { user_id: current_user.id, nickname: current_user.nickname } }
              end
        end
    end

    def destroy
        if @review != nil
            @review.destroy 
        end
    end

    private

    def reviews_params
        @reviews = params.require(:review).permit(:comment, :url)
    end

    def set_review
        @review = Review.where(id: params[:id], user: current_user).first
    end
end
