class FavoritesController < ApplicationController
  def index
    @favorite_pets = session[:favorites]
  end
end
