require 'rails_helper'

RSpec.describe "Delete Shelter with Pets", type: :feature do

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
    end

    it "when I delete the shelter" do
      pet1 = Pet.create(image_src: "https://free-classifieds-usa.com/oc-content/uploads/893/76682.jpg",
                            name: "Peanut",
                            approximate_age: "3",
                            sex: "M",
                            shelter_id: @shelter1.id,
                            status: "adoptable")
      pet2 = Pet.create(image_src: "https://thedogsjournal.com/wp-content/uploads/bfi_thumb/bernedoodle-prize-39zr02ajf5v660ii64zbbe.jpg",
                            name: "Biscuit",
                            approximate_age: "8",
                            sex: "F",
                            shelter_id: @shelter2.id,
                            status: "approved")
      pet3 = Pet.create(image_src: "https://cdn.fotofits.com/petzlover/gallery/img/l/samoyed-657170.jpg",
                            name: "Frank",
                            approximate_age: "1",
                            sex: "M",
                            shelter_id: @shelter1.id,
                            status: "adoptable")


      visit '/pets'
      expect(page).to have_content(pet1.name)
      expect(page).to have_content(pet2.name)
      expect(page).to have_content(pet3.name)

      visit "/shelters/#{@shelter1.id}"
      click_on 'delete'

      visit '/shelters'
      expect(page).to have_content(@shelter2.name)
      expect(page).to_not have_content(@shelter1.name)

      visit '/pets'
      expect(page).to_not have_content(pet1.name)
      expect(page).to have_content(pet2.name)
      expect(page).to_not have_content(pet3.name)
    end

    it "but I cannot delete shelter with approved pet status" do
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
                            status: "approved")

      visit '/shelters'
      expect(page).to have_content(@shelter2.name)
      expect(page).to have_content(@shelter1.name)

      visit "/shelters/#{@shelter1.id}"
      click_on 'delete'

      expect(page).to have_content("Meowch! Couldn't delete shelter because of pending adoption status.")

      visit '/shelters'
      expect(page).to have_content(@shelter2.name)
      expect(page).to have_content(@shelter1.name)
    end
  end
