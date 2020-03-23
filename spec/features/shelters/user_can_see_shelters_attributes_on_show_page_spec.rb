require 'rails_helper'

RSpec.describe "Shelters Show Page", type: :feature do
  it "shows shelter attributes on show page" do
    shelter1 = Shelter.create(name: 'Ricardos Reptiles', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    visit "shelters/#{shelter1.id}"

    expect(page).to have_content(shelter1.name)
    expect(page).to have_content(shelter1.address)
    expect(page).to have_content(shelter1.city)
    expect(page).to have_content(shelter1.state)
    expect(page).to have_content(shelter1.zip)

  end

  it "shelter can be deleted from show page" do
    shelter1 = Shelter.create(name: 'Ricardos Reptiles', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    visit "shelters/#{shelter1.id}"

    click_link ('Delete Shelter')

    expect(current_path).to eq("/shelters")
    expect(page).to_not have_content(shelter1.name)
  end

  it "shelter can be edited from show page" do
    shelter1 = Shelter.create(name: 'Ricardos Reptiles', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    visit "shelters/#{shelter1.id}"

    click_link ('Update Shelter')

    expect(current_path).to eq("/shelters/#{shelter1.id}/edit")

    fill_in "name", with: "AAA"
    fill_in "address", with: "BBB"
    fill_in "city", with: "CCC"
    fill_in "state", with: "DDD"
    fill_in "zip", with: "EEE"

    click_button ("Update Shelter")

    expect(current_path).to eq("/shelters/#{shelter1.id}")
    expect(page).to have_content("AAA")
    expect(page).to have_content("BBB")
    expect(page).to have_content("CCC")
    expect(page).to have_content("DDD")
    expect(page).to have_content("EEE")
    expect(page).to_not have_content("Ricardos Reptiles")
  end

  it "user can click link to view shelters pets" do
    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
    pet1 = shelter1.pets.create!(name: "Sam", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")
    pet2 = shelter1.pets.create!(name: "Melo", age: "3", sex: "Male", image: "https://i.pinimg.com/474x/8f/c4/68/8fc46860f9f52463e4e9db1ec32044f4--hady-reptile-room.jpg")

    visit "shelters/#{shelter1.id}"

    click_link "View Pets"

    expect(current_path).to eq("/shelters/#{shelter1.id}/pets")
  end
end
