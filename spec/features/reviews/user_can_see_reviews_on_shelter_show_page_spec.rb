require "rails_helper"

RSpec.describe "As a user when I visit a shelters show page", type: :feature do
  it "displays all reviews for that shelter" do
    shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")

    review1 = shelter1.reviews.create!(title: "This place is great", rating: 5, content:"wow good lizards", image: "https://c7.alamy.com/comp/XAABRH/guy-with-thumbs-up-XAABRH.jpg")

    visit "/shelters/#{shelter1.id}"

    expect(page).to have_content(review1.title)
    expect(page).to have_content(review1.rating)
    expect(page).to have_content(review1.content)
  end
end
