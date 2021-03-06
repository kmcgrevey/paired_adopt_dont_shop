require 'rails_helper'

RSpec.describe "On favorites index page", type: :feature do
  it "can see remove all favorites button and delete all favorites" do
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
    visit "/pets/#{pet2.id}"
    click_on "Add Pet to Favorites"

    visit "/favorites"
    expect(page).to have_button("Remove All Favorites")
    click_on "Remove All Favorites"
    expect(current_path).to eq("/favorites")
    expect(page).to have_content("No favorited pets")
    expect(page).to have_content("0 Favorites")
  end
end
