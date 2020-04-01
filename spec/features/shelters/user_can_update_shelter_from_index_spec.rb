require "rails_helper"

RSpec.describe "From the Shelters Index Page", type: :feature do
  it "user can click link to update shelter information" do

      shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")

      visit "/shelters"

      click_link ("Edit Shelter")

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
      expect(page).to_not have_content("Larry's Lizards")
  end

  it "user can delete shelters" do
    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")

    visit "/shelters"
    expect(page).to have_content("#{shelter1.name}")

    click_link ("Delete Shelter")

    expect(current_path).to eq("/shelters")
    expect(page).to_not have_content("#{shelter1.name}")
  end

  it "user cannot delete shelters that have approved applications for any of their pets" do
    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
    pet1 = shelter1.pets.create!(name: "Sam", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png", adoption_status: "Pending")
    pet2 = shelter1.pets.create!(name: "Melo", age: "3", sex: "Male", image: "https://i.pinimg.com/474x/8f/c4/68/8fc46860f9f52463e4e9db1ec32044f4--hady-reptile-room.jpg")

    visit "/shelters"

    click_link ("Delete Shelter")

    expect(page).to have_content("Error: cannot delete shelter with pending adoptions")

    expect(current_path).to eq("/shelters")
  end

 it "user can delete shelters that do not have pending applications for pets" do
   shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
   pet1 = shelter1.pets.create!(name: "Sam", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")
   pet2 = shelter1.pets.create!(name: "Melo", age: "3", sex: "Male", image: "https://i.pinimg.com/474x/8f/c4/68/8fc46860f9f52463e4e9db1ec32044f4--hady-reptile-room.jpg")

   visit "/shelters"

   click_link ("Delete Shelter")

   expect(page).to_not have_content(shelter1.name)
   expect(page).to_not have_content(pet1.name)
   expect(page).to_not have_content(pet2.name)

   expect(current_path).to eq("/shelters")
 end

 it "deleting a shelter also deletes that shelters reviews" do
   shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
   review1 = shelter1.reviews.create!(title: "This place is great", rating: "5", content:"wow good lizards", image: "https://c7.alamy.com/comp/XAABRH/guy-with-thumbs-up-XAABRH.jpg")

   visit "/shelters/#{shelter1.id}"

   click_link ("Delete Shelter")

   expect {shelter1.reload}.to raise_error ActiveRecord::RecordNotFound
   expect {review1.reload}.to raise_error ActiveRecord::RecordNotFound

   expect(current_path).to eq("/shelters")
 end

 it "shelter will not be updated unless all fields are filled in" do
    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: '80202')

    visit "/shelters"

    click_link ("Edit Shelter")

    fill_in "name", with: ""
    fill_in "address", with: "BBB"
    fill_in "city", with: "CCC"
    fill_in "state", with: "DDD"
    fill_in "zip", with: "EEE"

    click_button ("Update Shelter")

    expect(current_path).to eq("/shelters/#{shelter1.id}/edit")
    expect(page).to have_content("Name can't be blank")
  end
end
