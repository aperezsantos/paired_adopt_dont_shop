class Pet < ApplicationRecord

  validates_presence_of :name, :age, :sex
  belongs_to :shelter
  has_many :pet_applications, dependent: :destroy
  has_many :applications, through: :pet_applications

  def accepted_application
    applications.where(status: "Accepted")[0]
  end

end
