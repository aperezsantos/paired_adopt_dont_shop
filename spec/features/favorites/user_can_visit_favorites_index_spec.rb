require 'rails_helper'

RSpec.describe '', type: :feature do
  it "user sees flash message indicating pet is added to favorites list" do
    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
    pet1 = shelter1.pets.create!(name: "Sam", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")
    pet2 = shelter1.pets.create!(name: "Melo", age: "3", sex: "Male", image: "https://i.pinimg.com/474x/8f/c4/68/8fc46860f9f52463e4e9db1ec32044f4--hady-reptile-room.jpg")

    visit "/pets/#{pet1.id}"

    expect(page).to have_link("Add to Favorites")

    click_link "Add to Favorites"

    expect(current_path).to eq("/pets/#{pet1.id}")

    expect(page).to have_content("Pet has been added to Favorites")
    expect(page).to have_content("Favorites: 1")

    visit "/pets/#{pet2.id}"
    click_link "Add to Favorites"

    expect(page).to have_content("Pet has been added to Favorites")
    expect(page).to have_content("Favorites: 2")
  end

  it "user sees favorite pets in favorites index page" do
    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
    pet1 = shelter1.pets.create!(name: "Sam", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")
    pet2 = shelter1.pets.create!(name: "Melo", age: "3", sex: "Male", image: "https://i.pinimg.com/474x/8f/c4/68/8fc46860f9f52463e4e9db1ec32044f4--hady-reptile-room.jpg")

    visit "/pets/#{pet1.id}"
    click_link "Add to Favorites"

    visit "/pets/#{pet2.id}"
    click_link "Add to Favorites"

    visit "/favorites"

    expect(page).to have_content(pet1.name)
    expect(page).to have_css("img[src*='#{pet1.image}']")
    expect(page).to have_content(pet2.name)
    expect(page).to have_css("img[src*='#{pet2.image}']")
    click_on "#{pet1.name}"

    expect(current_path).to eq("/pets/#{pet1.id}")
  end
end
