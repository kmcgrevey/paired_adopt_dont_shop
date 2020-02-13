class FavoritesController < ApplicationController
  def index
    @favorite_pets = session[:favorites] ||= []
    @pets = Pet.all
  end

  def show
    @favorite_pets = session[:favorites]
    @pet = Pet.find(params[:id])
    redirect_to "/pets/#{@pet.id}"
  end

  def favorite
    @pet = Pet.find(params[:id])
    session[:favorites] ||= Favorite.new.pets
    session[:favorites] << @pet.id.to_s
    flash[:notice] = "#{@pet.name} was added to your favorites!"

    redirect_to "/pets/#{@pet.id}"
  end


  def remove
    @pet = Pet.find(params[:pet_id])
    @favorite_pets = session[:favorites]
    @favorite_pets.delete(@pet.id.to_s)
    session[:favorites] = @favorite_pets
    flash[:notice] = "#{@pet.name} was removed from your favorites."
    redirect_back fallback_location: "/pets"
  end

  def destroy
    @pet = Pet.find(params[:pet_id])
    @favorite_pets = session[:favorites]
    @favorite_pets.delete(@pet.id.to_s)
    session[:favorites] = @favorite_pets
    redirect_to "/favorites"
  end

  def destroy_all
    session[:favorites] = []
    @favorite_pets = session[:favorites]
    redirect_to "/favorites"
  end
end
