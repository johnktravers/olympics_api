class OlympianEvent < ApplicationRecord
  validates_presence_of :medal, allow_nil: true

  belongs_to :olympian
  belongs_to :event

  enum medal: [nil, 'bronze', 'silver', 'gold']
end
