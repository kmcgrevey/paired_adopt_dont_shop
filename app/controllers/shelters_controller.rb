class SheltersController < ApplicationController
  def index
      @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def new
  end

  def create
    shelter = Shelter.new(shelter_params)
    if shelter.save
      redirect_to '/shelters'
    else
      flash[:alert] = "Shelter not created: SHELTER NAME required."
      redirect_to '/shelters/new'
    end
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)
    if shelter.save
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:alert] = "Shelter not updated: SHELTER NAME required."
      redirect_to "/shelters/#{shelter.id}/edit"
    end
  end

  def destroy #REFACTOR TO MODEL and PORO?
    @pet_list = Shelter.find(params[:id]).pets
    if (@pet_list.any? { |pet| (pet.status == "pending") || (pet.status == "approved") }) == false
      destroy_pets
      destroy_reviews
      Shelter.destroy(params[:id])
    else
      flash[:alert] = "Meowch! Couldn't delete shelter because of active adoption status."
    end
    redirect_to '/shelters'
  end

  def destroy_pets
    @pet_list.each do |pet|
      Pet.destroy(pet.id.to_s)
    end
  end

  def destroy_reviews
    review_list = Shelter.find(params[:id]).reviews
    review_list.each do |review|
      Review.destroy(review.id.to_s)
    end
  end

  private

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
