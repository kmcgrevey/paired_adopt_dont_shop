require 'rails_helper'

RSpec.describe "index to new shelter form page", type: :feature do
  it "cannot create new shelter without name" do

    visit '/shelters'

    click_on 'Create New Shelter'

    expect(current_path).to eq('/shelters/new')
    expect(page).to have_content("Shelter name")
    expect(page).to have_content("Address")
    expect(page).to have_content("State")
    expect(page).to have_content("City")
    expect(page).to have_content("Zip")
    expect(page).to have_css('input', :count => 6)

    fill_in :city, with: "Denver"
    click_on 'Submit'

    expect(page).to have_content("Shelter not created: SHELTER NAME required.")
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
