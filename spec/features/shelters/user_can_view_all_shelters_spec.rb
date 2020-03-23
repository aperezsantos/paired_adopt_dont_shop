require 'rails_helper'

RSpec.describe "shelters index page", type: :feature do
  it "shows all shelters on the index page " do

    shelter1 = Shelter.create(name: 'Ricardos Reptiles', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")
    shelter2 = Shelter.create(name: "Freds Felines", address: "5678 st", city: 'Seattle', state: 'Washington', zip: "390507")
    shelter3 = Shelter.create(name: "Monroes Monitors", address: '2948 st', city: 'San Diego', state: 'California', zip: "30958")

    visit '/shelters'

    expect(page).to have_content(shelter1.name)
    expect(page).to have_content(shelter2.name)
    expect(page).to have_content(shelter3.name)

  end

  it "all shelter names are links to the shelter show page" do
    shelter1 = Shelter.create(name: 'Ricardos Reptiles', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")
    shelter2 = Shelter.create(name: "Freds Felines", address: "5678 st", city: 'Seattle', state: 'Washington', zip: "390507")
    shelter3 = Shelter.create(name: "Monroes Monitors", address: '2948 st', city: 'San Diego', state: 'California', zip: "30958")

    visit "/shelters"

    click_link("#{shelter1.name}")

    expect(current_path).to eq("/shelters/#{shelter1.id}")
  end

  it "there is a link to the shelter index page always at the top of the page" do

    shelter1 = Shelter.create(name: 'Ricardos Reptiles', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")
    shelter2 = Shelter.create(name: "Freds Felines", address: "5678 st", city: 'Seattle', state: 'Washington', zip: "390507")
    shelter3 = Shelter.create(name: "Monroes Monitors", address: '2948 st', city: 'San Diego', state: 'California', zip: "30958")

    visit "/pets"
    expect(page).to have_link("All Shelters")

    visit "/shelters"
    expect(page).to have_link("All Shelters")

    visit "/shelters/#{shelter1.id}"
    expect(page).to have_link("All Shelters")

    visit "/shelters/#{shelter2.id}"
    expect(page).to have_link("All Shelters")

    visit "/shelters/#{shelter3.id}"
    expect(page).to have_link("All Shelters")
  end

end
