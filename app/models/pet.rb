class Pet < ApplicationRecord
  belongs_to :shelter
  validates_presence_of :name, :approximate_age, :image_src
  has_many :application_pets
  has_many :applications, through: :application_pets
  # def find_shelter
  #   # self.shelter.name
  #   Shelter.find(shelter_id).name
  #   # self.id
  # end

  def application_pets
    # require "pry"; binding.pry
    Pet.joins(:applications)
    @pets = Pet.all
    application_pets = @pets.map do |pet|
      pet.name if pet.applications != []
    end
    # if application_pets == []
      # "No pets with applications"
    # else
      application_pets
    # end
  end

  def has_application
    Pet.joins(:applications)
    # require "pry"; binding.pry
    # application_pets.include?(pet.name)
  end
end
