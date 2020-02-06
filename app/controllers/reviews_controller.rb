class ReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter = Shelter.find(params[:id])
    # shelter.reviews.create(review_params)
    review = shelter.reviews.new(review_params)
    if review.save
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:alert] = "Review not created: Required information missing."
      # render :new
      redirect_to "/shelters/#{shelter.id}/reviews/new"
    end
  end

  private

  def review_params
    params.permit(:image_src, :title, :rating, :content)
  end
end
