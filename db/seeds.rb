# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Pet.destroy_all
Shelter.destroy_all
Review.destroy_all


shelter1 = Shelter.create(name: "Pups 4 U",
                       address: "208 Puppy Place",
                       city: "Denver",
                       state: "CO",
                       zip: 80211)

shelter2 = Shelter.create(name: "Furry Friends Shelter",
                        address: "7899 St Charles Ave",
                        city: "New Orleans",
                        state: "LA",
                        zip: 70118)

pet1 = Pet.create(image_src: "https://free-classifieds-usa.com/oc-content/uploads/893/76682.jpg",
                      name: "Peanut",
                      approximate_age: "3",
                      sex: "M",
                      status: "adoptable",
                      description: "",
                      shelter_id: shelter2.id)

pet2 = Pet.create(image_src: "https://thedogsjournal.com/wp-content/uploads/bfi_thumb/bernedoodle-prize-39zr02ajf5v660ii64zbbe.jpg",
                      name: "Biscuit",
                      approximate_age: "8",
                      sex: "F",
                      status: "adoptable",
                      description: "",
                      shelter_id: shelter1.id)

pet3 = Pet.create(image_src: "https://cdn.fotofits.com/petzlover/gallery/img/l/samoyed-657170.jpg",
                      name: "Frank",
                      approximate_age: "1",
                      sex: "M",
                      status: "adoptable",
                      description: "",
                      shelter_id: shelter1.id)

review1 = Review.create(title: "Awesome",
                        rating: "5",
                        content: "This place smells SO nice",
                        shelter: shelter1)
review2 = Review.create(title: "Meh",
                        rating: "3",
                        content: "I think my mom's basement is better",
                        image_src: "https://media.npr.org/assets/img/2014/12/31/allen-dogs2_slide-8899d50d4e46c5ad322c5a3a364310f15f555d6f-s800-c85.jpg",
                        shelter: shelter1)
