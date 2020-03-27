require 'rails_helper'

RSpec.describe 'as a user I see a favorites indicator', type: :feature do
  it "shows number of favorite pets in the navigation bar from any page" do

    visit '/shelters'

    expect(page).to have_content("Favorites: 0")

    visit '/pets'

    expect(page).to have_content("Favorites: 0")
  end

  it "links to the favorites index page when I click on it" do
    visit '/shelters'

    click_link "Favorites: 0"
    expect(current_path).to eq("/favorites")

    visit '/pets'

    click_link "Favorites: 0"
    expect(current_path).to eq("/favorites")
  end
end

  # User Story 11, Favorite Indicator links to Index Page
  #
  # As a visitor
  # When I click on the favorite indicator in the nav bar
  # I am taken to the favorites index page
