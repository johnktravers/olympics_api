class Team < ApplicationRecord
  validates_presence_of :country

  has_many :olympians
end
