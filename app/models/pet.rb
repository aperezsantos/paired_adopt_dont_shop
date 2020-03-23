class Pet < ApplicationRecord

  validates_presence_of :name, :age, :sex
  belongs_to :shelter

end
