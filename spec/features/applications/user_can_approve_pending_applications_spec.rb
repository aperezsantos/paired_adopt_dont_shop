require "rails_helper"

RSpec.describe "When I visit an applications show page", type: :feature do
  it "I can approve applications per specific pet" do
    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
    pet1 = shelter1.pets.create!(name: "Sam", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")
    pet2 = shelter1.pets.create!(name: "Melo", age: "3", sex: "Male", image: "https://i.pinimg.com/474x/8f/c4/68/8fc46860f9f52463e4e9db1ec32044f4--hady-reptile-room.jpg")

    application1 = Application.create!(name: "Jimbo", address: "test address", city: "test city", state: "test state", zip: "test zipcode", phone_number: "test phone number", description: "test description")
    application1.pets << pet1
    application1.pets << pet2

    visit "/applications/#{application1.id}"

    within("#application-#{pet1.id}") do
      expect(page).to have_link("Approve Application for Sam")
    end

    within("#application-#{pet2.id}") do
      expect(page).to have_link("Approve Application for Melo")
    end

    click_link("Approve Application for Sam")

    expect(current_path).to eq("/pets/#{pet1.id}")

    expect(page).to_not have_content("Status: Available")
    expect(page).to have_content("Status: Pending")
    expect(page).to have_content("On hold for Jimbo")
    expect(page).to have_link("Jimbo")
  end
end
