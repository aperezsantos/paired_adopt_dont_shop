require "rails_helper"

RSpec.describe "As a user when I visit a shelters show page", type: :feature do
  it "it displays all reviews for that shelter" do
    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")

    review1 = shelter1.reviews.create!(title: "This place is great", rating: "5", content:"wow good lizards", image: "https://c7.alamy.com/comp/XAABRH/guy-with-thumbs-up-XAABRH.jpg")

    visit "/shelters/#{shelter1.id}"

    expect(page).to have_content(review1.title)
    expect(page).to have_content(review1.rating)
    expect(page).to have_content(review1.content)
  end

  it "I see a link that I can click to add a new review" do
    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")

    visit "/shelters/#{shelter1.id}"

    expect(page).to have_link ("New Review")

    click_link("New Review")

    fill_in "Title", with: "Great Selection"
    fill_in "Rating", with: "5"
    fill_in "Content", with: "So many lizards, I didnt even know what to do with myself"

    click_button ("Submit")

    expect(current_path).to eq("/shelters/#{shelter1.id}")
    expect(page).to have_content("Great Selection")
    expect(page).to have_content("Rating(Out of 5): 5")
    expect(page).to have_content("So many lizards, I didnt even know what to do with myself")
  end

  it "If title, content, or rating are not filled, a flash message will tell user to try again" do
    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")

    visit "/shelters/#{shelter1.id}"

    expect(page).to have_link ("New Review")

    click_link("New Review")

    fill_in "Title", with: "Great Selection"
    fill_in "Content", with: "So many lizards, I didnt even know what to do with myself"

    click_button ("Submit")

    expect(current_path).to eq("/shelters/#{shelter1.id}/reviews")
    expect(page).to have_content("ERROR: Required fields not filled. Try Again")
  end

  it "I see a button next to reviews that I can use to edit it" do
    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")

    review1 = shelter1.reviews.create!(title: "This place is great", rating: "5", content:"wow good lizards", image: "https://c7.alamy.com/comp/XAABRH/guy-with-thumbs-up-XAABRH.jpg")

    visit "/shelters/#{shelter1.id}"

    expect(page).to have_content(review1.title)
    expect(page).to have_content(review1.rating.to_s)
    expect(page).to have_content(review1.content)
    expect(page).to have_link("Edit Review")

    click_link("Edit Review")

    expect(find_field(:title).value).to eq (review1.title)
    expect(find_field(:rating).value).to eq (review1.rating)
    expect(find_field(:content).value).to eq (review1.content)
    expect(current_path).to eq("/reviews/#{review1.id}/edit")

    fill_in "Title", with: "Test1"
    fill_in "Content", with: "Test2"
    fill_in "Rating", with: "4"

    click_on 'Update Review'

    expect(current_path).to eq("/shelters/#{shelter1.id}")
    expect(page).to_not have_content("This place is great")
    expect(page).to have_content("Test1")
    expect(page).to have_content("Test2")
  end
end
