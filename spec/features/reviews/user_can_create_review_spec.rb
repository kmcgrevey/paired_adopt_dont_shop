require 'rails_helper'

RSpec.describe "When I visit a shelter page", type: :feature do
  before(:each) do
    @shelter1 = Shelter.create(name: "Pups 4 U",
                               address: "208 Puppy Place",
                               city: "Denver",
                               state: "CO",
                               zip: 80211)
  end

  it "I can create a review" do

    visit "/shelters/#{@shelter1.id}"

    click_on 'Create New Review'
    expect(current_path).to eq("/shelters/#{@shelter1.id}/reviews/new")

    fill_in :title, with: "Sweet"
    fill_in :rating, with: "4"
    fill_in :content, with: "The kitty litter here has a great texture."
    fill_in :image_src, with: "https://cdni.rt.com/files/2017.01/article/58729ff9c36188be5d8b45e4.jpg"

    expect(page).to have_css('input', :count => 5)

    click_on 'Submit'

    expect(current_path).to eq("/shelters/#{@shelter1.id}")

    new_review = Review.last

    # expect(new_review.title).to eq("Sweet") #ALTERNATE TEST?
    expect(page).to have_content("Sweet")
    expect(page).to have_content("4")
    expect(page).to have_content("The kitty litter here has a great texture.")
    expect(page).to have_css("img[src*='#{new_review.image_src}']")
  end

  it 'I cannot create a review without a name, rating and content' do
    visit "/shelters/#{@shelter1.id}/reviews/new"

    click_on 'Submit'

    expect(page).to have_content("Review not created: Required information missing.")
    expect(page).to have_button('Submit')
  end
end
