class FavoritesController < ApplicationController
  def index
    @favorite_pets = session[:favorites] ||= []
    # require "pry"; binding.pry
    @pets = Pet.all
  end

  def show
    @favorite_pets = session[:favorites]
    @pet = Pet.find(params[:id])
    redirect_to "/pets/#{@pet.id}"
  end

  def favorite
    @pet = Pet.find(params[:id])
    # session[:favorites] = @favorites
    # @favorites ||= Favorite.new
    session[:favorites] ||= Favorite.new.pets #move to poro -store session in object not object in session
    # @favorites.pets << @pet
    session[:favorites] << @pet.id.to_s #move to poro and just save id
    flash[:notice] = "#{@pet.name} was added to your favorites!"
    # render "pets/show"
    # render :show
    # redirect_back
    redirect_to "/pets/#{@pet.id}"
  end

  # def show
  #
  # end

  def remove
    @pet = Pet.find(params[:pet_id])
    @favorite_pets = session[:favorites]
    @favorite_pets.delete(@pet.id.to_s)
    session[:favorites] = @favorite_pets
    flash[:notice] = "#{@pet.name} was removed from your favorites."
    # render "pets/show"
    redirect_back fallback_location: "/pets"
    # redirect_to "/pets/#{@pet.id}"
  end

  def remove_index
    @pet = Pet.find(params[:pet_id])
    @favorite_pets = session[:favorites]
    @favorite_pets.delete(@pet.id.to_s)
    session[:favorites] = @favorite_pets
    # flash[:notice] = "#{@pet.name} was removed from your favorites."
    # render "pets/show"
    redirect_to "/favorites"
  end

  def remove_all
    session[:favorites] = []
    @favorite_pets = session[:favorites]
    redirect_to "/favorites"
  end
end
