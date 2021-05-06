class ReviewsController < ApplicationController
    before_action :reviews_params, only: :create

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

    private

    def reviews_params
        @reviews = params.require(:review).permit(:comment, :url)
    end
end
