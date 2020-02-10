require 'rails_helper'

RSpec.describe "index to new shelter form page", type: :feature do
  xit "cannot create new shelter without name" do
    # shelter1 = Shelter.create(name: "Pups 4 U",
    #                        address: "208 Puppy Place",
    #                        city: "Denver",
    #                        state: "CO",
    #                        zip: 80211)

    # shelter2 = Shelter.create(name: "Furry Friends Shelter",
    #                         address: "7899 St Charles Ave",
    #                         city: "New Orleans",
    #                         state: "LA",
    #                         zip: 70118)

    visit '/shelters'

    click_on 'Create New Shelter'

    expect(current_path).to eq('/shelters/new')
    expect(page).to have_content("Shelter name:")
    expect(page).to have_content("Address:")
    expect(page).to have_content("State:")
    expect(page).to have_content("City:")
    expect(page).to have_content("Zip:")
    expect(page).to have_css('input', :count => 6)

    fill_in :city, with: "Denver"

    # save_and_open_page
    click_on 'Submit'

    expect(page).to have_content("Shelter not created: NAME required.")
    expect(page).to have_content("New Shelter Information")

    expect(page).to have_button('Submit')
  end

  it "can go to new shelter form and submit" do
    visit '/shelters/new'

    fill_in :name, with: "Pups 4 U"

    click_on 'Submit'
    visit '/shelters'

    expect(page).to have_content("Pups 4 U")
  end
end
