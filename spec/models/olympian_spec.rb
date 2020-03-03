require 'rails_helper'

RSpec.describe Olympian, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }

    it { should validate_presence_of :age }
    it { should validate_presence_of :sex }
    it { should validate_presence_of(:height).allow_nil }
    it { should validate_presence_of(:weight).allow_nil }

    it { should validate_inclusion_of(:sex).in_array(['M', 'F']) }

    it { should validate_numericality_of(:age).only_integer }
    it { should validate_numericality_of(:age).is_greater_than(0) }

    it { should validate_numericality_of(:height).allow_nil }
    it { should validate_numericality_of(:height).only_integer }
    it { should validate_numericality_of(:height).is_greater_than(0) }

    it { should validate_numericality_of(:weight).allow_nil }
    it { should validate_numericality_of(:weight).only_integer }
    it { should validate_numericality_of(:weight).is_greater_than(0) }
  end

  describe 'relationships' do
    it { should belong_to :team }
    it { should belong_to :sport }
    it { should have_many :olympian_events }
  end
end
