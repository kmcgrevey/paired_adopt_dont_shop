require 'rails_helper'

RSpec.describe "update shelter form page", type: :feature do
  it "can go to update shelter form and submit" do
    shelter1 = Shelter.create(name: "Poops 4 U",
                           address: "208 Poopy Place",
                           city: "Denver",
                           state: "CO",
                           zip: 80211)

    visit "/shelters/#{shelter1.id}"

    expect(page).to have_content("Poops 4 U")
    expect(page).to have_content("208 Poopy Place")
    click_button 'Update Shelter'
    expect(current_path).to eq("/shelters/#{shelter1.id}/edit")

    fill_in :name, with: "Pups 4 U"
    fill_in :address, with: "208 Puppy Place"
    click_on 'Submit'

    expect(current_path).to eq("/shelters/#{shelter1.id}")
    expect(page).to have_content("Pups 4 U")
    expect(page).to have_content("208 Puppy Place")
  end

  it "cannot update if name is missing" do
    shelter2 = Shelter.create(name: "Furry Friends Shelter",
                            address: "7899 St Charles Ave",
                            city: "New Orleans",
                            state: "LA",
                            zip: 70118)

    visit "/shelters/#{shelter2.id}/edit"

    fill_in :name, with: ""
    click_on 'Submit'

    expect(page).to have_content("Shelter not updated: SHELTER NAME required.")
  end
end
