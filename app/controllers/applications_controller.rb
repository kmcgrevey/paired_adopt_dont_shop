class ApplicationsController < ApplicationController
  def new
  end

  def create
    if application_params.values.include?("") || params[:pet_ids]==nil
      flash[:notice] = "Please fill out all fields."
      redirect_back fallback_location: "/applications/new"
    else
      application = Application.create(application_params)
      @pets ||= []
      params[:pet_ids].each do |pet|
        @pet = Pet.find(pet)
        @pets << @pet.name
        @application = ApplicationPet.create(application: application, pet: @pet)
        @favorite_pets = session[:favorites]
        @favorite_pets.delete(@pet.id.to_s)
      end
      pet_string = @pets.to_sentence#@pets.map(&:inspect).join(', ')
      flash[:notice] = "Your application for #{pet_string} was submitted"
      redirect_to '/favorites'
      # render '/favorites/'
      # render 'app/views/favorites/index.html.erb'
    # redirect_to 'favorites#remove_index'
    # redirect_to '@favorites_remove_index_path'
    # redirect_to '/favorites/remove_index'
    # redirect_back
    end
  end

  def index
    pet = Pet.find(params[:id])
    @applications = pet.applications
    # @applications = Application.all

    # @application_pets = []
    # @applications.each do |application|
    #   @application_pets << application.pets
    # end
    # require "pry"; binding.pry
  end

  def show
    @application = Application.find(params[:id])
  end

  def approve
    application = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    if pet.status.downcase == "adoptable"
      # @app_id = application.id  maybe try session hash here
      pet.status = "Pending. On hold for #{application.name} /#{application.id}"
      pet.save
      # @message = "On hold for #{application.name}"
      redirect_to "/pets/#{pet.id}"
    else
      # pet = application.pets.find {|pet| pet.status.downcase == 'pending'}
      pet.status = "Adoptable"
      pet.save
      redirect_to "/applications/#{application.id}"
    end
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
