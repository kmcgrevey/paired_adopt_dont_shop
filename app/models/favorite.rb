class Favorite
  attr_reader :pets

  def initialize
    @pets ||= new_pets_array
  end

  def new_pets_array
    Array.new
  end # this shouldn't be an array it should create individual shelter objects

  # def has_application
  #   require "pry"; binding.pry
  # end

end
