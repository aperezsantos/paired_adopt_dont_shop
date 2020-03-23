class Shelter < ApplicationRecord
  has_many :pets

  validates_presence_of :name
end
