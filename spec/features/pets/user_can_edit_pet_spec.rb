require 'rails_helper'

RSpec.describe "update pet form page", type: :feature do
  before(:each) do
    @shelter1 = Shelter.create(name: "Pups 4 U",
                           address: "208 Puppy Place",
                           city: "Denver",
                           state: "CO",
                           zip: 80211)

    @pet1 = Pet.create(image_src: "https://free-classifieds-usa.com/oc-content/uploads/893/76682.jpg",
                          name: "Peanut",
                          approximate_age: "3",
                          sex: "M",
                          status: "adoptable",
                          description: "soft",
                          shelter_id: @shelter1.id)
  end

  it "can go to update pet form and submit" do
    visit "/pets/#{@pet1.id}"

    expect(page).to have_content("Peanut")

    click_on 'Edit'

    expect(current_path).to eq("/pets/#{@pet1.id}/edit")

    fill_in :name, with: "Buttercup"
    fill_in :description, with: "Buttercup is friendly and energetic"

    click_button 'Submit'

    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to have_content("Buttercup")
    expect(page).to have_content("Buttercup is friendly and energetic")
  end

  it "cannot update without missing information" do

    visit "/pets/#{@pet1.id}/edit"

    expect(page).to have_content("Edit Pet Information")
    expect(page).to have_content("(required)")

    fill_in :name, with: ""
    fill_in :image_src, with: ""

    click_button 'Submit'

    expect(page).to have_content("Pet not updated: Please provide required information.")
    expect(page).to have_content("Name")
    expect(page).to have_content("Approximate age")
    expect(page).to have_content("Image")
  end
end
