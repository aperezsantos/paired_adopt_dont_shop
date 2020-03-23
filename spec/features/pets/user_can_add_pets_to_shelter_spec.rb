require 'rails_helper'

RSpec.describe "As a user, when I visit a shelters pet index page", type: :feature do
  it "Has a link to add new pets to that shelter" do

    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")

    pet1 = shelter1.pets.create!(name: "Sam", description: "Slippery Snake", adoption_status: "Available", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")
    pet2 = shelter1.pets.create!(name: "Melo", age: "3",description: "Slipperier Snake", adoption_status: "Available", sex: "Male", image: "https://i.pinimg.com/474x/8f/c4/68/8fc46860f9f52463e4e9db1ec32044f4--hady-reptile-room.jpg")

    visit "/shelters/#{shelter1.id}/pets"

    click_link "Create Pet"

    expect(current_path).to eq("/shelters/#{shelter1.id}/pets/new")

    fill_in "Image", with: "https://c7.alamy.com/comp/BTJYP4/jamaican-giant-anole-jamaican-crested-anole-anolis-garmani-on-bark-BTJYP4.jpg"
    fill_in "Name", with: "Spazzy"
    fill_in "Description", with: "Lil Slipper"
    fill_in "Age", with: "4"
    fill_in "sex", with: "male"

    expect(page).to have_button("Submit")

    click_on "Submit"

    expect(current_path).to eq("/shelters/#{shelter1.id}/pets")

    expect(page).to have_content("Spazzy")
    expect(page).to have_content("4")
    expect(page).to have_content("male")
    expect(page).to have_content("Available")

  end
end

# User Story 10, Shelter Pet Creation
#
# As a visitor
# When I visit a Shelter Pets Index page
# Then I see a link to add a new adoptable pet for that shelter "Create Pet"
# When I click the link
# I am taken to '/shelters/:shelter_id/pets/new' where I see a form to add a new adoptable pet
# When I fill in the form with the pet's:
# - image
# - name
# - description
# - approximate age
# - sex ('female' or 'male')
# And I click the button "Create Pet"
# Then a `POST` request is sent to '/shelters/:shelter_id/pets',
# a new pet is created for that shelter,
# that pet has a status of 'adoptable',
# and I am redirected to the Shelter Pets Index page where I can see the new pet listed
