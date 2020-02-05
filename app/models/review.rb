class Review < ApplicationRecord
  belongs_to :shelter

  validates_presence_of :title, :rating, :content
  # WHAT IS CODE FOR OPTIONAL VALIDATION OF IMAGE :image_src
end
