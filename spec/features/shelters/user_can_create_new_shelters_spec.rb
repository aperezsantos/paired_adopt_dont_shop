require 'rails_helper'

RSpec.describe "A user can create new shelters", type: :feature do
  it "can create new shelter from shelter index page" do
    visit "/shelters"

    click_link "New Shelter"

    fill_in "name", with: "AAA"
    fill_in "address", with: "BBB"
    fill_in "city", with: "CCC"
    fill_in "state", with: "DDD"
    fill_in "zip", with: "EEE"

    click_button ("Submit")

    expect(current_path).to eq("/shelters")
    expect(page).to have_content("AAA")
  end

#create
  it "shelter will not be created unless all fields are filled in" do
     shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: '80202')

     visit "/shelters"

     click_link "New Shelter"

     fill_in "name", with: ""
     fill_in "address", with: "BBB"
     fill_in "city", with: "CCC"
     fill_in "state", with: "DDD"
     fill_in "zip", with: "EEE"

     click_button ("Submit")

     expect(current_path).to eq("/shelters/new")
     expect(page).to have_content("Name can't be blank")
   end
end
