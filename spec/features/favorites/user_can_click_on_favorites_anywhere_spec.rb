require 'rails_helper'

RSpec.describe "From any page" do
  it "can click on favorites button and go to favorites index" do
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

    visit "/pets/#{pet2.id}"
    click_on "Add Pet to Favorites"

    visit "/pets"
    click_on "2 Favorites"

    expect(current_path).to eq("/favorites")
    expect(page).to have_content(pet2.name)
    expect(page).to have_content(pet1.name)
  end
end
