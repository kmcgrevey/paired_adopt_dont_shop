require 'rails_helper'

RSpec.describe "Delete Shelter", type: :feature do
  describe "when I visit a shelter show page" do

    before(:each) do
      @shelter1 = Shelter.create(name: "Pups 4 U",
        address: "208 Puppy Place",
        city: "Denver",
        state: "CO",
        zip: 80211)

      @shelter2 = Shelter.create(name: "Furry Friends Shelter",
        address: "7899 St Charles Ave",
        city: "New Orleans",
        state: "LA",
        zip: 70118)

      review1 = Review.create(title: "Awesome",
                              rating: "5",
                              content: "This place smells SO nice",
                              shelter: @shelter1)
      review2 = Review.create(title: "Meh",
                              rating: "3",
                              content: "I think my mom's basement is better",
                              image_src: "https://media.npr.org/assets/img/2014/12/31/allen-dogs2_slide-8899d50d4e46c5ad322c5a3a364310f15f555d6f-s800-c85.jpg",
                                                      shelter: @shelter1)
    end

    it "I can delete the shelter" do
      visit '/shelters'
      expect(page).to have_content(@shelter2.name)
      expect(page).to have_content(@shelter1.name)

      visit "/shelters/#{@shelter1.id}"
      click_on 'delete'

      visit '/shelters'
      expect(page).to have_content(@shelter2.name)
      expect(page).to_not have_content(@shelter1.name)
    end

    it "I cannot delete shelter with pending pet status" do
      pet1 = Pet.create(image_src: "https://free-classifieds-usa.com/oc-content/uploads/893/76682.jpg",
                            name: "Peanut",
                            approximate_age: "3",
                            sex: "M",
                            shelter_id: @shelter1.id,
                            status: "pending")

      pet2 = Pet.create(image_src: "https://thedogsjournal.com/wp-content/uploads/bfi_thumb/bernedoodle-prize-39zr02ajf5v660ii64zbbe.jpg",
                            name: "Biscuit",
                            approximate_age: "8",
                            sex: "F",
                            shelter_id: @shelter1.id,
                            status: "adoptable")

      visit '/shelters'
      expect(page).to have_content(@shelter2.name)
      expect(page).to have_content(@shelter1.name)

      visit "/shelters/#{@shelter1.id}"
      click_on 'delete'

      expect(page).to have_content("Meowch! Couldn't delete shelter because of active adoption status.")

      visit '/shelters'
      expect(page).to have_content(@shelter2.name)
      expect(page).to have_content(@shelter1.name)
    end
  end
end
