require 'rails_helper'

RSpec.describe "From a favorites index page" do
  it "can see list of pets with applications" do
    shelter1 = Shelter.create(name: "Pups 4 U",
                           address: "208 Puppy Place",
                           city: "Denver",
                           state: "CO",
                           zip: 80211)

    pet1 = Pet.create(image_src: "https://thedogsjournal.com/wp-content/uploads/bfi_thumb/bernedoodle-prize-39zr02ajf5v660ii64zbbe.jpg",
                          name: "Biscuit",
                          approximate_age: "8",
                          sex: "F",
                          shelter_id: shelter1.id)

    application = Application.create(name: "Kathleen",
                                    address: "4330 Pecos St",
                                    city: "Denver",
                                    state: "CO",
                                    zip: "80211",
                                    phone_number: "3037186690",
                                    description: "I will be a great owner",
                                    pet: pet1)

    pet2 = Pet.create(image_src: "https://cdn.fotofits.com/petzlover/gallery/img/l/samoyed-657170.jpg",
                          name: "Frank",
                          approximate_age: "1",
                          sex: "M",
                          shelter_id: shelter1.id)

    pet3 = Pet.create(image_src: "https://cdn.fotofits.com/petzlover/gallery/img/l/samoyed-657170.jpg",
                          name: "Frank",
                          approximate_age: "1",
                          sex: "M",
                          shelter_id: shelter1.id)

    application2 = Application.create(name: "Kathleen",
                                    address: "4330 Pecos St",
                                    city: "Denver",
                                    state: "CO",
                                    zip: "80211",
                                    phone_number: "3037186690",
                                    description: "I will be a great owner",
                                    pet: pet3)

    visit "/pets/#{pet2.id}"
    click_on "Add Pet to Favorites"

    visit "/favorites"

    expect(page).to have_content("#{pet2.name}")
    expect(page).to_not have_content("#{pet1.name}")

    within("#apps") do
      expect(page).to have_content("Applications for Pets:")
      expect(page).to have_content("#{pet1.name}")
      expect(page).to have_content("#{pet3.name}")
      expect(page).to_not have_content("#{pet2.name}")

      click_on "#{pet1.name}"
      expect(current_path).to eq("/pets/#{pet1.id}")
    end
  end
end
