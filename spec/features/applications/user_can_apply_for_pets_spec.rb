require "rails_helper"

RSpec.describe "As a User when I visit the favorites index page", type: :feature do
  it "There is a link I can click on to apply for pets" do

    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
    pet1 = shelter1.pets.create!(name: "Sam", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")
    pet2 = shelter1.pets.create!(name: "Melo", age: "3", sex: "Male", image: "https://i.pinimg.com/474x/8f/c4/68/8fc46860f9f52463e4e9db1ec32044f4--hady-reptile-room.jpg")

    visit "/pets/#{pet1.id}"
    click_link "Add to Favorites"

    visit "/pets/#{pet2.id}"
    click_link "Add to Favorites"

    visit "/favorites"

    expect(page).to have_link("Adopt Pets")
    click_link("Adopt Pets")

    expect(current_path).to eq("/applications/new")

    within("#pets-#{pet1.id}") do
      page.check
    end
    within("#pets-#{pet2.id}") do
      page.check
    end

    fill_in "Name", with: "Jimmy"
    fill_in "Address", with: "2050 Blake St"
    fill_in "City", with: "Denver"
    fill_in "State", with: "CO"
    fill_in "Zip", with: "80237"
    fill_in "Phone Number", with: "55555555555"
    fill_in "Tell us about yourself", with: "Test"

    click_button "Submit Application"

    expect(page).to have_content("Application Submitted Succesfully")
    expect(current_path).to eq("/favorites")


    expect(page).not_to have_selector("#pets-#{pet1.id}")
    expect(page).not_to have_selector("#pets-#{pet2.id}")
  end

  it "When applying, if you dont fill in the application fully, there is a flash message and the page refreshes" do
    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
    pet1 = shelter1.pets.create!(name: "Sam", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")
    pet2 = shelter1.pets.create!(name: "Melo", age: "3", sex: "Male", image: "https://i.pinimg.com/474x/8f/c4/68/8fc46860f9f52463e4e9db1ec32044f4--hady-reptile-room.jpg")

    visit "/pets/#{pet1.id}"
    click_link "Add to Favorites"


    visit "/pets/#{pet2.id}"
    click_link "Add to Favorites"

    visit "/favorites"

    click_link("Adopt Pets")

    within("#pets-#{pet1.id}") do
      page.check
    end

    click_button "Submit Application"

    expect(page).to have_content("Please fill out application fully before submiting")
    expect(current_path).to eq("/applications/new")

  end

  it "Displays pets that have applications pending at the bottom of the screen" do

    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
    pet1 = shelter1.pets.create!(name: "Sam", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")
    pet2 = shelter1.pets.create!(name: "Melo", age: "3", sex: "Male", image: "https://i.pinimg.com/474x/8f/c4/68/8fc46860f9f52463e4e9db1ec32044f4--hady-reptile-room.jpg")

    visit "/pets/#{pet1.id}"
    click_link "Add to Favorites"

    visit "/pets/#{pet2.id}"
    click_link "Add to Favorites"

    visit "/favorites"

    expect(page).to have_link("Adopt Pets")
    click_link("Adopt Pets")

    expect(current_path).to eq("/applications/new")

    within("#pets-#{pet1.id}") do
      page.check
    end

    fill_in "Name", with: "Jimmy"
    fill_in "Address", with: "2050 Blake St"
    fill_in "City", with: "Denver"
    fill_in "State", with: "CO"
    fill_in "Zip", with: "80237"
    fill_in "Phone Number", with: "55555555555"
    fill_in "Tell us about yourself", with: "Test"

    click_button "Submit Application"

    expect(current_path).to eq("/favorites")
    expect(page).to have_content("Pets with Pending Applications")

    within("#application-#{pet1.id}") do
      expect(page).to have_link("Sam")
      click_link("Sam")
    end
    expect(current_path).to eq("/pets/#{pet1.id}")
  end

end
