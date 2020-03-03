class Olympian < ApplicationRecord
  validates_presence_of :name, :age, :sex
  validates_uniqueness_of :name
  validates_inclusion_of :sex, in: ['M', 'F']

  validates_presence_of :height, allow_nil: true
  validates_presence_of :weight, allow_nil: true

  validates_numericality_of :age, greater_than: 0, only_integer: true
  validates_numericality_of :height, greater_than: 0, only_integer: true, allow_nil: true
  validates_numericality_of :weight, greater_than: 0, only_integer: true, allow_nil: true

  belongs_to :team
  belongs_to :sport
  has_many :olympian_events
  has_many :events, through: :olympian_events
end
