class Favorite
  attr_reader :pets

  def initialize
    @pets ||= new_pets_array
  end

  def new_pets_array
    Array.new
  end


end
