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
    shelter = Shelter.new({
      name: params[:shelter][:name],
      address: params[:shelter][:address],
      state: params[:shelter][:state],
      zip: params[:shelter][:zip]
      })

    shelter.save

    redirect_to '/shelters'
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update({
      name: params[:shelter][:name],
      address: params[:shelter][:address],
      city: params[:shelter][:city],
      state: params[:shelter][:state],
      zip: params[:shelter][:zip]
      })
    shelter.save
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy #REFACTOR TO MODEL and PORO
    pet_list = Shelter.find(params[:id]).pets # LIST OF PETS
    if (pet_list.any? { |pet| (pet.status == "pending") || (pet.status == "approved") }) == false
      # NEED TO DELETE EACH PET FROM db BEFORE SHELTER
      pet_list.each do |pet|
        Pet.destroy(pet.id.to_s)
      end
      Shelter.destroy(params[:id])
    else
      flash[:alert] = "Meowch! Couldn't delete shelter because of active adoption status."
    end
    redirect_to '/shelters'
  end
end
