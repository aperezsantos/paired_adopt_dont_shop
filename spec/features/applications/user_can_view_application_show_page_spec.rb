require "rails_helper"

RSpec.describe "When user visits the applications show page", type: :feature do
  it "Displays all of the attributes of that application" do
    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
    pet1 = shelter1.pets.create!(name: "Sam", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")
    pet2 = shelter1.pets.create!(name: "Melo", age: "3", sex: "Male", image: "https://i.pinimg.com/474x/8f/c4/68/8fc46860f9f52463e4e9db1ec32044f4--hady-reptile-room.jpg")

    application1 = Application.create!(name: "Jimbo", address: "test address", city: "test city", state: "test state", zip: "test zipcode", phone_number: "test phone number", description: "test description")

    application1.pets << pet1
    application1.pets << pet2

    visit "/applications/#{application1.id}"

    expect(page).to have_content("Jimbo")
    expect(page).to have_content("test address")
    expect(page).to have_content("test city")
    expect(page).to have_content("test state")
    expect(page).to have_content("test zipcode")
    expect(page).to have_content("test phone number")
    expect(page).to have_content("test description")

    expect(page).to have_link("Sam")
    expect(page).to have_link("Melo")

    click_link("Melo")
    expect(current_path).to eq("/pets/#{pet2.id}")
  end

  it "applications can be viewed from the pets show page" do

    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
    pet1 = shelter1.pets.create!(name: "Sam", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")
    pet2 = shelter1.pets.create!(name: "Melo", age: "3", sex: "Male", image: "https://i.pinimg.com/474x/8f/c4/68/8fc46860f9f52463e4e9db1ec32044f4--hady-reptile-room.jpg")

    application1 = Application.create!(name: "Jimbo", address: "test address", city: "test city", state: "test state", zip: "test zipcode", phone_number: "test phone number", description: "test description")
    application2 = Application.create!(name: "Jerry", address: "test address", city: "test city", state: "test state", zip: "test zipcode", phone_number: "test phone number", description: "test description")

    application1.pets << pet1
    application2.pets << pet1

    visit "/pets/#{pet1.id}"

    expect(page).to have_link("View All Applications")
    click_link("View All Applications")

    expect(current_path).to eq("/pets/#{pet1.id}/applications")

    expect(page).to have_link("Jimbo")
    expect(page).to have_link("Jerry")

    click_link("Jimbo")

    expect(current_path).to eq("/applications/#{application1.id}")
  end

  it "when I visit the application index for a pet with no applications, I see a message saying such" do
    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
    pet1 = shelter1.pets.create!(name: "Sam", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")

    visit "/pets/#{pet1.id}"

    expect(page).to_not have_link("View All Applications")
    expect(page).to have_content("No Current Applications for this Pet")
  end
end
