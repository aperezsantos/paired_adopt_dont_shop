class ReviewsController < ApplicationController

  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    review = Review.create(review_params)
    redirect_to "/shelters/#{shelter.id}"
  end

  private

    def review_params
      params.permit(:title, :rating, :content, :picture, :shelter_id)
    end
end
