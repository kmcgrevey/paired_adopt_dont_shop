require 'rails_helper'

RSpec.describe "From a application show page" do
  it "can see applications for pets and approve pets and revoke and get flash message" do
    shelter1 = Shelter.create(name: "Pups 4 U",
                           address: "208 Puppy Place",
                           city: "Denver",
                           state: "CO",
                           zip: 80211)

    pet1 = Pet.create(image_src: "https://thedogsjournal.com/wp-content/uploads/bfi_thumb/bernedoodle-prize-39zr02ajf5v660ii64zbbe.jpg",
                          name: "Biscuit",
                          approximate_age: "8",
                          sex: "F",
                          status: "adoptable",
                          description: "Biscuit is so cute is hurts.  Friendly, lovable, and fun.",
                          shelter_id: shelter1.id)

    pet2 = Pet.create(image_src: "https://cdn.fotofits.com/petzlover/gallery/img/l/samoyed-657170.jpg",
                          name: "Frank",
                          approximate_age: "1",
                          sex: "M",
                          status: "adoptable",
                          description: "Frank loves to run",
                          shelter_id: shelter1.id)

    application = Application.create(name: "Kathleen",
                                    address: "4330 Pecos St",
                                    city: "Denver",
                                    state: "CO",
                                    zip: "80211",
                                    phone_number: "3037186690",
                                    description: "I will be a great owner",
                                    pets: [pet1])

    pet3 = Pet.create(image_src: "https://cdn.fotofits.com/petzlover/gallery/img/l/samoyed-657170.jpg",
                          name: "Frank",
                          approximate_age: "1",
                          sex: "M",
                          status: "adoptable",
                          description: "Frank loves to run",
                          shelter_id: shelter1.id)

    application2 = Application.create(name: "Bob",
                                    address: "4330 Pecos St",
                                    city: "Denver",
                                    state: "CO",
                                    zip: "80211",
                                    phone_number: "3037186690",
                                    description: "I will be a great owner",
                                    pets: [pet3, pet1])

    visit "/applications/#{application2.id}"

    within("#pet-#{pet1.id}") do
      # check()
      expect(page).to have_button("Approve Pet")
      click_on "Approve Pet"
      expect(current_path).to eq("/pets/#{pet1.id}")
    end

    visit "/applications/#{application2.id}"

    within("#pet-#{pet1.id}") do
      expect(page).to have_button("Revoke")
      click_on "Revoke"
    end

    visit "/applications/#{application2.id}"

    within("#pet-#{pet1.id}") do
      expect(page).to have_button("Approve Pet")
      click_on "Approve Pet"
    end

    visit "/applications/#{application2.id}"

    within("#pet-#{pet3.id}") do
      # check()
      expect(page).to have_button("Approve Pet")
      click_on "Approve Pet"
      expect(current_path).to eq("/pets/#{pet3.id}")
    end

    visit "/applications/#{application.id}"

    within("#pet-#{pet1.id}") do
      # check()
      # save_and_open_page
      # expect(page).to have_button("Approve Pet")
      # click_on "Approve Pet"
      expect(page).to have_content("No more applications can be approved for this pet at this time.")
    end
  end
end
