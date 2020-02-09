require 'rails_helper'

RSpec.describe "When a user sees shelter reviews", type: :feature do
  it "they can delete a review" do
    shelter1 = Shelter.create(name: "Pups 4 U",
                           address: "208 Puppy Place",
                           city: "Denver",
                           state: "CO",
                           zip: 80211)
    review1 = Review.create(title: "Awesome",
                            rating: "5",
                            content: "This place smells SO nice",
                            shelter: shelter1)
    review2 = Review.create(title: "Meh",
                            rating: "3",
                            content: "I think my mom's basement is better",
                            image_src: "https://media.npr.org/assets/img/2014/12/31/allen-dogs2_slide-8899d50d4e46c5ad322c5a3a364310f15f555d6f-s800-c85.jpg",
                            shelter: shelter1)

    visit "/shelters/#{shelter1.id}"

    expect(page).to have_content('Awesome')
    expect(page).to have_content('Meh')
    expect(page).to have_css("img[src*='#{review2.image_src}']")

    within("#review-#{review2.id}") do
      click_on 'Delete Review'
    end

    expect(page).to have_content('Awesome')
    expect(page).to_not have_content('Meh')
    expect(page).to_not have_content('3')
    expect(page).to_not have_content("I think my mom's basement is better")
    expect(page).to_not have_css("img[src*='#{review2.image_src}']")
  end
end
