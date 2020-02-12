require 'rails_helper'

RSpec.describe "update pet form page", type: :feature do
  before(:each) do
    @shelter1 = Shelter.create(name: "Pups 4 U",
                           address: "208 Puppy Place",
                           city: "Denver",
                           state: "CO",
                           zip: 80211)

    # shelter2 = Shelter.create(name: "Furry Friends Shelter",
    #                         address: "7899 St Charles Ave",
    #                         city: "New Orleans",
    #                         state: "LA",
    #                         zip: 70118)

    @pet1 = Pet.create(image_src: "https://free-classifieds-usa.com/oc-content/uploads/893/76682.jpg",
                          name: "Peanut",
                          approximate_age: "3",
                          sex: "M",
                          shelter_id: @shelter1.id)

    # pet2 = Pet.create(image_src: "https://thedogsjournal.com/wp-content/uploads/bfi_thumb/bernedoodle-prize-39zr02ajf5v660ii64zbbe.jpg",
    #                       name: "Biscuit",
    #                       approximate_age: "8",
    #                       sex: "F",
    #                       shelter_id: shelter1.id)
    #
    # pet3 = Pet.create(image_src: "https://cdn.fotofits.com/petzlover/gallery/img/l/samoyed-657170.jpg",
    #                       name: "Frank",
    #                       approximate_age: "1",
    #                       sex: "M",
    #                       shelter_id: shelter1.id)
  end

  it "can go to update pet form and submit" do
    visit "/pets/#{@pet1.id}"

    expect(page).to have_content("Peanut")

    click_on 'Edit'

    expect(current_path).to eq("/pets/#{@pet1.id}/edit")
    # expect(page).to have_css('textarea', :count => 5)
# save_and_open_page

    fill_in :name, with: "Buttercup"
    fill_in :description, with: "Buttercup is friendly and energetic"

    click_button 'Submit'

    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to have_content("Buttercup")
    expect(page).to have_content("Buttercup is friendly and energetic")
  end

  xit "cannot update without missing information" do
    shelter1 = Shelter.create(name: "Pups 4 U",
                           address: "208 Puppy Place",
                           city: "Denver",
                           state: "CO",
                           zip: 80211)

    visit "/shelters/#{shelter1.id}/pets/new"

    expect(page).to have_content("Edit Pet Information")
    expect(page).to have_content("(required)")

    fill_in :name, with: "Boots"
save_and_open_page
    click_button 'Add New Pet'

    expect(page).to have_content("Pet not updated: Please provide required information.")
    expect(page).to have_content("Name")
    expect(page).to have_content("Approximate age")
    expect(page).to have_content("Image")
  end
end
