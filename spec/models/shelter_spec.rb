require 'rails_helper'

describe Shelter, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :pets }
    it { should have_many :reviews }
  end

  it "calculate average rating" do
    shelter1 = Shelter.create(name: "Pups 4 U")
    review1 = Review.create(title: "Awesome",
                              rating: "5",
                              content: "This place smells SO nice",
                              shelter: shelter1)
    review2 = Review.create(title: "Meh",
                              rating: "3",
                              content: "I think my mom's basement is better",
                              shelter: shelter1)

    expect(shelter1.average_rating).to eq(4)

    review3 = Review.create(title: "Seriously",
                              rating: "3",
                              content: "Totally average in every way",
                              shelter: shelter1)

    expect(shelter1.average_rating.to_d).to be_within(1e-12).of(0.36666666666666667e1)

  end
end
