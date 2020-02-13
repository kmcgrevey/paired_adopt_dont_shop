require 'rails_helper'

RSpec.describe "From a favorites index page" do
  it "can see adopt pet button and go to new application form" do
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
                          description: "soft",
                          shelter_id: shelter1.id)

    pet2 = Pet.create(image_src: "https://cdn.fotofits.com/petzlover/gallery/img/l/samoyed-657170.jpg",
                          name: "Frank",
                          approximate_age: "1",
                          sex: "M",
                          status: "adoptable",
                          description: "soft",
                          shelter_id: shelter1.id)

    visit "/pets/#{pet1.id}"
    click_on "Add Pet to Favorites"

    visit "/favorites"
    click_on "Adopt Pets"

    expect(page).to have_content("Select pets to adopt:")
    check()
    fill_in :name, with: "Kathleen"
    fill_in :address, with: "123 Penny Lane"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80211"
    fill_in :phone_number, with: "3037186690"
    fill_in :description, with: "I am a loving owner looking for a new dog"
    click_on "Submit"

    expect(page).to have_content("Your application for #{pet1.name} was submitted")
    expect(current_path).to eq("/favorites")
    within('#pets') do
      expect(page).to_not have_content("#{pet1.name}")
    end
  end
end
