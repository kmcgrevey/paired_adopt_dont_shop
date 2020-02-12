require 'rails_helper'

RSpec.describe "From a favorites index page" do
  it "can not submit form with blanks and get redirected back to new application form" do
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

    pet2 = Pet.create(image_src: "https://cdn.fotofits.com/petzlover/gallery/img/l/samoyed-657170.jpg",
                          name: "Frank",
                          approximate_age: "1",
                          sex: "M",
                          shelter_id: shelter1.id)

    visit "/pets/#{pet1.id}"
    click_on "Add Pet to Favorites"

    visit "/favorites"
    click_on "Adopt Pets"

    # find(:css, "#pet[value='#{pet1.id}']").set(true)
    # within('#check') do
      # find("label", text: "#{pet1.name}").click
      # check "#{pet1.id}"
    # end
    # click_on "Submit"
    expect(current_path).to eq("/applications/new")
    # expect(page).to have_content("Please fill out all fields.")

    # find(:css, "#pet[value='#{pet1.id}']").set(true)
    within("#favorite-#{pet1.id}") do
      check "pet_ids_"
    end
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
    # save_and_open_page
    within('#pets') do
      expect(page).to_not have_content("#{pet1.name}")
    end
  end
end
