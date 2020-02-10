require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe "relationships" do
    it {should have_many :application_pets}
    it {should have_many(:applications).through(:application_pets)}
  end
end
