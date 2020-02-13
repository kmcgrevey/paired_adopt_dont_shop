class Pet < ApplicationRecord
  belongs_to :shelter
  validates_presence_of :name, :approximate_age, :image_src
  has_many :application_pets
  has_many :applications, through: :application_pets
end
