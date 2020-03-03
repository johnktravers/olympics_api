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

  def total_medals_won
    olympian_events.where('medal > 0').count
  end

  def self.youngest_olympians
    youngest_age = order(:age).first.age
    where(age: youngest_age).order(:id)
  end

  def self.oldest_olympians
    oldest_age = order(age: :desc).first.age
    where(age: oldest_age).order(:id)
  end

  def self.total_competing_olympians
    count
  end

  def self.average_weight_by_sex(sex)
    where(sex: sex).average(:weight)
  end

  def self.average_age
    average(:age)
  end
end
