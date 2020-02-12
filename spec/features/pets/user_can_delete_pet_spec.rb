require 'rails_helper'

RSpec.describe "Delete Pet", type: :feature do
    before(:each) do
      @shelter1 = Shelter.create(name: "Pups 4 U",
                           address: "208 Puppy Place",
                           city: "Denver",
                           state: "CO",
                           zip: 80211)
    end

    it "when its status is not pending" do
      pet1 = Pet.create(image_src: "https://free-classifieds-usa.com/oc-content/uploads/893/76682.jpg",
                        name: "Peanut",
                        approximate_age: "3",
                        sex: "M",
                        shelter_id: @shelter1.id,
                        status: "adoptable")

      visit "/pets"
      expect(page).to have_content(pet1.name)

      click_on "Peanut"
      expect(page).to have_content(pet1.name)

      click_on "delete"

      expect(current_path).to eq('/pets')
      expect(page).to_not have_content("Peanut")
    end

    it "cannot delete while it status is pending" do
      pet1 = Pet.create(image_src: "https://free-classifieds-usa.com/oc-content/uploads/893/76682.jpg",
                        name: "Peanut",
                        approximate_age: "3",
                        sex: "M",
                        shelter_id: @shelter1.id,
                        status: "approved")

      visit "/pets/#{pet1.id}"
      expect(page).to have_content("Peanut")

      click_on "delete"

      expect(current_path).to eq("/pets/#{pet1.id}")
      expect(page).to have_content("Peanut")
      expect(page).to have_content("Pet not deleted due to adoption status.")
    end
end
