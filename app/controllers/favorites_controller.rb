class FavoritesController < ApplicationController
  def index
    @favorite_pets = session[:favorites] ||= []
  end

  def show
    @favorite_pets = session[:favorites]
  end

  def favorite
    @pet = Pet.find(params[:id])
    # session[:favorites] = @favorites
    # @favorites ||= Favorite.new
    session[:favorites] ||= Favorite.new.pets #move to poro
    # @favorites.pets << @pet
    session[:favorites] << @pet.id.to_s #move to poro and just save id
    flash[:notice] = "#{@pet.name} was added to your favorites!"
    # render "pets/show"
    # render :show
    redirect_to "/pets/#{@pet.id}"
  end

  def show
    @pet = Pet.find(params[:id])
    redirect_to "/pets/#{@pet.id}"
  end

  def remove
    @pet = Pet.find(params[:pet_id])
    @favorite_pets = session[:favorites]
    @favorite_pets.delete(@pet.id.to_s)
    session[:favorites] = @favorite_pets
    flash[:notice] = "#{@pet.name} was removed from your favorites."
    # render "pets/show"
    redirect_to "/pets/#{@pet.id}"
  end
end
