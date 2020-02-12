require 'rails_helper'

RSpec.describe "From a pets show page" do
  it "can see list of applications for pet with links to applications" do
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
                          description: "Biscuit is so cute is hurts.  Friendly, lovable, and fun.",
                          shelter_id: shelter1.id)

    pet2 = Pet.create(image_src: "https://cdn.fotofits.com/petzlover/gallery/img/l/samoyed-657170.jpg",
                          name: "Frank",
                          approximate_age: "1",
                          sex: "M",
                          status: "adoptable",
                          description: "Frank loves to run",
                          shelter_id: shelter1.id)

    application = Application.create(name: "Kathleen",
                                    address: "4330 Pecos St",
                                    city: "Denver",
                                    state: "CO",
                                    zip: "80211",
                                    phone_number: "3037186690",
                                    description: "I will be a great owner",
                                    pets: [pet1])

    pet3 = Pet.create(image_src: "https://cdn.fotofits.com/petzlover/gallery/img/l/samoyed-657170.jpg",
                          name: "Frank",
                          approximate_age: "1",
                          sex: "M",
                          status: "adoptable",
                          description: "Frank loves to run",
                          shelter_id: shelter1.id)

    application2 = Application.create(name: "Bob",
                                    address: "4330 Pecos St",
                                    city: "Denver",
                                    state: "CO",
                                    zip: "80211",
                                    phone_number: "3037186690",
                                    description: "I will be a great owner",
                                    pets: [pet3, pet1])

    visit "/pets/#{pet1.id}"
    click_on "View All Applications"
    expect(page).to have_content("#{application.name}")
    expect(page).to have_content("#{application2.name}")

    click_on "#{application2.name}"
    expect(current_path).to eq("/applications/#{application2.id}")

    visit "/pets/#{pet3.id}"
    click_on "View All Applications"
    expect(page).to have_content("#{application2.name}")

    visit "/pets/#{pet2.id}"
    click_on "View All Applications"
    expect(page).to have_content("No Applications for this pet")
  end
end
