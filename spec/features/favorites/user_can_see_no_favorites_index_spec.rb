require 'rails_helper'

RSpec.describe "On favorites index page", type: :feature do
  it "can see no pets added to favorites if no favorites" do
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

    visit '/favorites'
    expect(page).to have_content("No favorited pets")
    expect(page).to_not have_content(pet1.name)

    visit "/pets/#{pet1.id}"
    click_on "Add Pet to Favorites"

    visit '/favorites'
    expect(page).to have_content(pet1.name)
  end
end
