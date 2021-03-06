class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def pets
    @shelter = Shelter.find(params[:shelter_id])
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def create
    shelter = Shelter.find(params[:id])
    potential_pet = shelter.pets.create(pet_params)
    if potential_pet.save
      redirect_to "/shelters/#{shelter.id}/pets"
    else
      flash[:alert] = "Pet not created: Please provide required information."
      redirect_to "/shelters/#{shelter.id}/pets/new"
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)
    if pet.save
      redirect_to "/pets/#{pet.id}"
    else
      flash[:alert] = "Pet not updated: Please provide required information."
      redirect_to "/pets/#{pet.id}/edit"
    end
  end

  def destroy
    pet = Pet.find(params[:id])
    if pet.status != "approved"
      session[:favorites].delete(pet.id.to_s) if session[:favorites] != nil
      Pet.destroy(params[:id])
      redirect_to '/pets'
    else
      flash[:alert] = "Pet not deleted due to adoption status."
      redirect_to "/pets/#{pet.id}"
    end
  end

  private

  def pet_params
    params.permit(:image_src, :name, :approximate_age, :sex, :description, :status)
  end
end
