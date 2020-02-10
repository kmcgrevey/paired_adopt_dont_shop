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

  def destroy #REFACTOR TO MODEL IF TIME
    pet_list = Shelter.find(params[:id]).pets # LIST OF PETS
    if (pet_list.any? { |pet| pet.status == "pending" }) == false
      # pet_list.each do |pet|
      #   #WRITE pet[:shelter_id] => ""
      # end
      Shelter.destroy(params[:id])
    else
      flash[:alert] = "Meowch! Couldn't delete shelter because of pending adoption status."
    end
    redirect_to '/shelters'
  end
end
