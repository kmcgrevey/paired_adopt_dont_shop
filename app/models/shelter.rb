class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews

  validates_presence_of :name


    def average_rating
      if reviews != []
          reviews.average("rating::int")
      else
        0
      end
    end

end
