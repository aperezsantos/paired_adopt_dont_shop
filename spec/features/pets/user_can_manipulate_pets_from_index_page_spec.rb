require 'rails_helper'

RSpec.describe "From the pets index page", type: :feature do
  it "user can update pet information" do

    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
    pet1 = shelter1.pets.create!(name: "Sam", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")

    visit "/pets"

    expect(page).to have_content(pet1.name)
    expect(page).to have_content(pet1.age)
    expect(page).to have_content(pet1.sex)

    click_link "Edit Pet"

    fill_in "Image", with: "https://reptilerapture.net/assets/images/cuban-knight-anole2.JPG"
    fill_in "Name", with: "Yoel"
    fill_in "description", with: "A bit Bitey"
    fill_in "Age", with: "5"
    fill_in "sex", with: "Male"

    expect(page).to have_button("Submit")

    click_on "Submit"

    expect(current_path).to eq("/pets/#{pet1.id}")

    expect(page).to have_content("Yoel")
    expect(page).to have_content("A bit Bitey")
  end
  it "user can delete pets" do

    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
    pet1 = shelter1.pets.create!(name: "Sam", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")

    visit "/pets"

    expect(page).to have_content(pet1.name)
    expect(page).to have_content(pet1.age)
    expect(page).to have_content(pet1.sex)

    click_link "Delete Pet"

    expect(current_path).to eq("/pets")
    expect(page).to_not have_content(pet1.name)
    expect(page).to_not have_content(pet1.age)
    expect(page).to_not have_content(pet1.sex)

  end
end
