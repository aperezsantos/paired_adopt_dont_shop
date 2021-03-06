require 'rails_helper'

RSpec.describe "as a user When I visit '/shelters/:shelter_id/pets'", type: :feature do
  it "I see each Pet that can be adopted from that Shelter" do

    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
    shelter2 = Shelter.create!(name: "Ricardos Reptiles", address: "150 Main Street", city: 'Hershey', state: 'PA', zip: "17033")
    pet1 = shelter1.pets.create!(name: "Sam", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")
    pet2 = shelter1.pets.create!(name: "Melo", age: "3", sex: "Male", image: "https://i.pinimg.com/474x/8f/c4/68/8fc46860f9f52463e4e9db1ec32044f4--hady-reptile-room.jpg")

    pet3 = shelter2.pets.create!(name: "Lemmy", age: "3", sex: "Male", image: "https://i.redd.it/ypu5ydssuar21.jpg")
    pet4 = shelter2.pets.create!(name: "Hot Stuff", age: "5", sex: "Male", image: "https://pm1.narvii.com/7052/9058c2ef22124550d8f4a57d98f1cbaf0a2d8ac2r1-900-614v2_hq.jpg")

    visit "/shelters/#{shelter1.id}/pets"

    expect(page).to have_content(pet1.name)
    expect(page).to have_content(pet2.name)

    expect(page).to have_content(pet1.age)
    expect(page).to have_content(pet2.age)

    expect(page).to have_content(pet1.sex)
    expect(page).to have_content(pet2.sex)

    visit "/shelters/#{shelter2.id}/pets"

    expect(page).to have_content(pet3.name)
    expect(page).to have_content(pet4.name)

    expect(page).to have_content(pet3.age)
    expect(page).to have_content(pet4.age)

    expect(page).to have_content(pet3.sex)
    expect(page).to have_content(pet4.sex)
  end

  it "User can click on pets name to be taken to its show page" do
    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
    pet1 = shelter1.pets.create!(name: "Sam", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")
    pet2 = shelter1.pets.create!(name: "Melo", age: "3", sex: "Male", image: "https://i.pinimg.com/474x/8f/c4/68/8fc46860f9f52463e4e9db1ec32044f4--hady-reptile-room.jpg")

    visit "/shelters/#{shelter1.id}/pets"

    click_link("#{pet1.name}")

    expect(current_path).to eq("/pets/#{pet1.id}")
  end

  it "has a count of the number of pets at that shelter" do
    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
    pet1 = shelter1.pets.create!(name: "Sam", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")
    pet2 = shelter1.pets.create!(name: "Melo", age: "3", sex: "Male", image: "https://i.pinimg.com/474x/8f/c4/68/8fc46860f9f52463e4e9db1ec32044f4--hady-reptile-room.jpg")

    visit "/shelters/#{shelter1.id}/pets"

    expect(page).to have_content(pet1.name)
    expect(page).to have_content(pet2.name)

    expect(page).to have_content(pet1.age)
    expect(page).to have_content(pet2.age)

    expect(page).to have_content(pet1.sex)
    expect(page).to have_content(pet2.sex)

    expect(page).to have_content("Total Pets: 2")
  end
end
