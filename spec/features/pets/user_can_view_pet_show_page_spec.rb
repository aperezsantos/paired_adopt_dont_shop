require "rails_helper"

RSpec.describe "As a user When I visit '/pets/:id'", type: :feature do
    it "I see all of the pets information" do

      shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")

      pet1 = shelter1.pets.create!(name: "Sam", description: "Slippery Snake", adoption_status: "Available", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")
      pet2 = shelter1.pets.create!(name: "Melo", age: "3",description: "Slipperier Snake", adoption_status: "Available", sex: "Male", image: "https://i.pinimg.com/474x/8f/c4/68/8fc46860f9f52463e4e9db1ec32044f4--hady-reptile-room.jpg")

      visit "/pets/#{pet1.id}"

      expect(page).to have_content(pet1.name)
      expect(page).to have_content(pet1.age)
      expect(page).to have_content(pet1.sex)
      expect(page).to have_content(pet1.description)
      expect(page).to have_content(pet1.adoption_status)

      visit "/pets/#{pet2.id}"

      expect(page).to have_content(pet2.name)
      expect(page).to have_content(pet2.age)
      expect(page).to have_content(pet2.sex)
      expect(page).to have_content(pet2.description)
      expect(page).to have_content(pet2.adoption_status)

  end

  it "there is a link to delete the pet" do
    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")

    pet1 = shelter1.pets.create!(name: "Sam", description: "Slippery Snake", adoption_status: "Available", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")
    pet2 = shelter1.pets.create!(name: "Melo", age: "3",description: "Slipperier Snake", adoption_status: "Available", sex: "Male", image: "https://i.pinimg.com/474x/8f/c4/68/8fc46860f9f52463e4e9db1ec32044f4--hady-reptile-room.jpg")


    visit "/pets/#{pet1.id}"

    expect(page).to have_link("Delete Pet")
    click_link("Delete Pet")

    expect(current_path).to eq("/pets")

    expect(page).to_not have_content(pet1.name)
    expect(page).to_not have_content(pet1.age)
    expect(page).to_not have_content(pet1.sex)
    expect(page).to_not have_content(pet1.description)
    expect(page).to_not have_content(pet1.adoption_status)

  end

  it "there is a link to update pet information" do

    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")

    pet1 = shelter1.pets.create!(name: "Sam", description: "Slippery Snake", adoption_status: "Available", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")
    pet2 = shelter1.pets.create!(name: "Melo", age: "3",description: "Slipperier Snake", adoption_status: "Available", sex: "Male", image: "https://i.pinimg.com/474x/8f/c4/68/8fc46860f9f52463e4e9db1ec32044f4--hady-reptile-room.jpg")

    visit "/pets/#{pet1.id}"

    expect(page).to have_link("Update Pet")
    click_link("Update Pet")

    expect(current_path).to eq("/pets/#{pet1.id}/edit")

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

  it "I cannot delete it if it has an approved pet application" do
    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
    pet1 = shelter1.pets.create!(name: "Sam", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png", adoption_status: "Pending")
    pet2 = shelter1.pets.create!(name: "Melo", age: "3", sex: "Male", image: "https://i.pinimg.com/474x/8f/c4/68/8fc46860f9f52463e4e9db1ec32044f4--hady-reptile-room.jpg")
    application1 = Application.create!(name: "Jimbo", address: "test address", city: "test city", state: "test state", zip: "test zipcode", phone_number: "test phone number", description: "test description", status: "Accepted")

    application1.pets << pet1

    visit "/pets/#{pet1.id}"

    click_link "Delete Pet"

    expect(page).to have_content("Error: cannot delete pet with pending adoption")

    expect(current_path).to eq("/pets/#{pet1.id}")
  end

  it "pet will not be updated unless all fields are filled in" do
     shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: '80202')
     pet1 = shelter1.pets.create!(name: "Sam", description: "Slippery Snake", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")

     visit "/pets/#{pet1.id}"

     click_link("Update Pet")

     fill_in "Image", with: "https://reptilerapture.net/assets/images/cuban-knight-anole2.JPG"
     fill_in "Name", with: ""
     fill_in "description", with: "A bit Bitey"
     fill_in "Age", with: "5"
     fill_in "sex", with: "Male"

     click_on "Submit"

     expect(page).to have_content("Name can't be blank")
  end
end
