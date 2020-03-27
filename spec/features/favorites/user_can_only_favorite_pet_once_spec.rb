require 'rails_helper'

RSpec.describe '', type: :feature do
  it "user sees flash message indicating pet is added to favorites list" do
    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
    pet1 = shelter1.pets.create!(name: "Sam", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")
    pet2 = shelter1.pets.create!(name: "Melo", age: "3", sex: "Male", image: "https://i.pinimg.com/474x/8f/c4/68/8fc46860f9f52463e4e9db1ec32044f4--hady-reptile-room.jpg")

    visit "/pets/#{pet1.id}"

    expect(page).to have_link("Add to Favorites")

    click_link "Add to Favorites"

    expect(current_path).to eq("/pets/#{pet1.id}")

    expect(page).to_not have_link("Add to Favorites")
    expect(page).to have_link("Remove from Favorites")

    click_link "Remove from Favorites"

    expect(current_path).to eq("/pets/#{pet1.id}")

    expect(page).to have_content("Pet has been removed from Favorites")

    expect(page).to have_link("Add to Favorites")
    expect(page).to have_content("Favorites: 0")
  end
end

# User Story 12, Can't Favorite a Pet More Than Once
#
# As a visitor
# After I've favorited a pet
# When I visit that pet's show page
# I no longer see a link to favorite that pet
# But I see a link to remove that pet from my favorites
# When I click that link
# A delete request is sent to "/favorites/:pet_id"
# And I'm redirected back to that pets show page where I can see a flash message indicating that the pet was removed from my favorites
# And I can now see a link to favorite that pet
# And I also see that my favorites indicator has decremented by 1
