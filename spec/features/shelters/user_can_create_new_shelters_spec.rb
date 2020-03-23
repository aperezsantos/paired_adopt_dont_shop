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
end
