class ReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter = Shelter.find(params[:id])
    review = shelter.reviews.new(review_params)
    if review.save
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:alert] = "Review not created: Required information missing."
      redirect_to "/shelters/#{shelter.id}/reviews/new"
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    review.update(review_params)
    if review.save
      redirect_to "/shelters/#{review.shelter_id}"
    else
      flash[:alert] = "Review not updated: Required information missing."
      redirect_to "/reviews/#{review.id}/edit"
    end
  end

  def destroy
    review = Review.find(params[:id])
    Review.destroy(params[:id])
    redirect_to "/shelters/#{review.shelter_id}"
  end

  private

  def review_params
    params.permit(:image_src, :title, :rating, :content)
  end
end
