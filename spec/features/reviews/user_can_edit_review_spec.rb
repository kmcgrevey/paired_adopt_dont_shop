require 'rails_helper'

RSpec.describe "When a user sees shelter reviews", type: :feature do
  it "they can edit a review" do
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

    within("#review-#{review1.id}") do
      click_on 'Edit Review'
    end

    expect(current_path).to eq("/reviews/#{review1.id}/edit")

    expect(page).to have_field(:title, with: 'Awesome')
    expect(page).to have_field(:rating, with: '5')
    expect(page).to have_field(:content, with: 'This place smells SO nice')


    fill_in :content, with: "This place smells SO nice -- and so does the staff!"

    click_on 'Submit'

    expect(current_path).to eq("/shelters/#{shelter1.id}")

    expect(page).to have_content("This place smells SO nice -- and so does the staff!")
  end

  it "they see a flash message for incomplete field inputs" do
    shelter1 = Shelter.create(name: "Pups 4 U",
                           address: "208 Puppy Place",
                           city: "Denver",
                           state: "CO",
                           zip: 80211)
    review2 = Review.create(title: "Meh",
                            rating: "3",
                            content: "I think my mom's basement is better",
                            image_src: "https://media.npr.org/assets/img/2014/12/31/allen-dogs2_slide-8899d50d4e46c5ad322c5a3a364310f15f555d6f-s800-c85.jpg",
                            shelter: shelter1)

    visit "/reviews/#{review2.id}/edit"

    expect(page).to have_field(:rating, with: '3')
    fill_in :rating, with: ""

    click_on 'Submit'

    expect(page).to have_content("Review not updated: Required information missing.")
  end
end
