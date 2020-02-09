require 'rails_helper'

RSpec.describe "From a pets show page" do
  it "can see favorites button and add pet to favorites" do
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
    expect(page).to have_content("0 Favorites")
    expect(page).to have_button("Add Pet to Favorites")

    click_on "Add Pet to Favorites"
    expect(page).to have_content("1 Favorites")
    expect(page).to have_content("#{pet1.name} was added to your favorites!")

    visit "/pets"
    expect(page).to have_content("1 Favorites")

    visit "/pets/#{pet2.id}"
    expect(page).to have_content("1 Favorites")
    expect(page).to have_button("Add Pet to Favorites")

    click_on "Add Pet to Favorites"
    expect(page).to have_content("#{pet2.name} was added to your favorites!")
    expect(page).to have_content("2 Favorites")
  end
end
