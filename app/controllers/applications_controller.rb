class ApplicationsController < ApplicationController
  def new
  end

  def create
    # require "pry"; binding.pry
    @pet = Pet.find(params[:pet])
    @application = @pet.applications.create(application_params)

    @favorite_pets = session[:favorites]
    @favorite_pets.delete(@pet.id.to_s)
    flash[:notice] = "Your application for #{@pet.name} was submitted"
    redirect_to '/favorites'
    # redirect_to 'favorites#remove_index'
    # redirect_to '@favorites_remove_index_path'
    # redirect_to '/favorites/remove_index'
    # redirect_back
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
