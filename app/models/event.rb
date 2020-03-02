class Event < ApplicationRecord
  validates_presence_of :name

  belongs_to :sport
  has_many :olympian_events
end
