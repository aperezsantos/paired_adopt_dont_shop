require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :age}
    it {should validate_presence_of :sex}

  end

  describe "relationship" do
    it {should belong_to :shelter}
    it {should have_many :pet_applications}
    it {should have_many(:applications).through(:pet_applications)}
  end

  describe "#approved_application" do
    it "returns application for pets with status accepted" do
      shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
      pet1 = shelter1.pets.create!(name: "Sam", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png", adoption_status: "Pending")

      application1 = Application.create!(name: "Jimbo", address: "test address", city: "test city", state: "test state", zip: "test zipcode", phone_number: "test phone number", description: "test description", status: "Accepted")
      application1.pets << pet1

      expect(pet1.accepted_application).to eq(application1)
    end
  end

end
