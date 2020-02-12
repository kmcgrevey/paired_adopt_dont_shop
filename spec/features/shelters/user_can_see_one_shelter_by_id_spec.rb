require 'rails_helper'

RSpec.describe "shelter id page", type: :feature do
  before (:each) do
    @shelter1 = Shelter.create(name: "Pups 4 U",
                           address: "208 Puppy Place",
                           city: "Denver",
                           state: "CO",
                           zip: 80211)

    @shelter2 = Shelter.create(name: "Furry Friends Shelter",
                            address: "7899 St Charles Ave",
                            city: "New Orleans",
                            state: "LA",
                            zip: 70118)
  end

  it "can see one shelters and info" do
    visit "/shelters/#{@shelter1.id}"

    expect(page).to have_content(@shelter1.name)
    expect(page).to have_content("#{@shelter1.address} #{@shelter1.city}, #{@shelter1.state} #{@shelter1.zip}")

    visit "/shelters/#{@shelter2.id}"

    expect(page).to have_content(@shelter2.name)
    expect(page).to have_content("#{@shelter2.address} #{@shelter2.city}, #{@shelter2.state} #{@shelter2.zip}")
  end

  it "can see shelter stats" do
    pet1 = Pet.create(image_src: "https://free-classifieds-usa.com/oc-content/uploads/893/76682.jpg",
      name: "Peanut",
      approximate_age: "3",
      sex: "M",
      shelter_id: @shelter1.id)

    pet2 = Pet.create(image_src: "https://thedogsjournal.com/wp-content/uploads/bfi_thumb/bernedoodle-prize-39zr02ajf5v660ii64zbbe.jpg",
      name: "Biscuit",
      approximate_age: "8",
      sex: "F",
      shelter_id: @shelter1.id)

    pet3 = Pet.create(image_src: "https://cdn.fotofits.com/petzlover/gallery/img/l/samoyed-657170.jpg",
      name: "Frank",
      approximate_age: "1",
      sex: "M",
      shelter_id: @shelter1.id)

    review1 = Review.create(title: "Awesome",
                              rating: "5",
                              content: "This place smells SO nice",
                              shelter: @shelter1)
    review2 = Review.create(title: "Meh",
                              rating: "3",
                              content: "I think my mom's basement is better",
                              shelter: @shelter1)
    review3 = Review.create(title: "Seriously",
                              rating: "3",
                              content: "Totally average in every way",
                              shelter: @shelter1)
    app = Application.create(name: "Kathleen",
                             address: "4330 Pecos St",
                             city: "Denver",
                             state: "CO",
                             zip: "80211",
                             phone_number: "3037186690",
                             description: "I will be a great owner",
                             pets: [pet1, pet2])


    visit "/shelters/#{@shelter1.id}"

    expect(page).to have_content("Pet Count: 3")
    expect(page).to have_content("Average Rating: 3.7")
    expect(page).to have_content("Apps on File: 1")

    app2 = Application.create(name: "Kevin",
      address: "3025 S Birch St",
      city: "Denver",
      state: "CO",
      zip: "80222",
      phone_number: "3178821471",
      description: "I need sum dawgs.",
      pets: [pet1, pet3])

    visit "/shelters/#{@shelter1.id}"

    expect(page).to have_content("Apps on File: 2")
  end
end
