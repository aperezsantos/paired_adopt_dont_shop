class ReviewsController < ApplicationController

  def new
    @shelter_id = params[:shelter_id]
  end

  def edit
    @review = Review.find(params[:id])
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to "/shelters/#{review.shelter.id}"
  end

  def update
    review = Review.find(params[:id])
      if review.update(review_params)
        redirect_to "/shelters/#{review.shelter.id}"
      else
        flash[:notice] = "ERROR: Required fields not filled. Try Again"
        redirect_to "/reviews/#{review.id}/edit"
      end
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    review = Review.new(review_params)
      if review.save
        redirect_to "/shelters/#{shelter.id}"
      else
        flash.now[:notice] = "ERROR: Required fields not filled. Try Again"
        render :new
      end
  end

  private

    def review_params
      params.permit(:title, :rating, :content, :picture, :shelter_id)
    end
end
