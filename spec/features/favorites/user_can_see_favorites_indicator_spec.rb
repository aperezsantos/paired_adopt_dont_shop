require 'rails_helper'

RSpec.describe 'Favorites indicator', type: :feature do
  it "shows number of favorite pets in the navigation bar from any page" do

    visit '/shelters'

    expect(page).to have_content("Favorites: 0")

    visit '/pets'

    expect(page).to have_content("Favorites: 0")
  end
end
