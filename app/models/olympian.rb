class Olympian < ApplicationRecord
  validates_presence_of :name, :age, :sex, :height, :weight

  validates_inclusion_of :sex, in: ['M', 'F']

  validates_numericality_of :age, greater_than: 0, only_integer: true
  validates_numericality_of :height, greater_than: 0, only_integer: true
  validates_numericality_of :weight, greater_than: 0, only_integer: true

  belongs_to :team
  belongs_to :sport
  has_many :olympian_events
end
