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
    it { should have_many(:events).through(:olympian_events) }
  end

  describe 'instance methods' do
    it 'total_medals_won' do
      olympian = create(:olympian)

      expect(olympian.total_medals_won).to eq(0)

      create_list(:olympian_event, 5, medal: 0, olympian: olympian)
      create_list(:olympian_event, 2, medal: 1, olympian: olympian)
      create(:olympian_event, medal: 2, olympian: olympian)
      create(:olympian_event, medal: 3, olympian: olympian)

      expect(olympian.total_medals_won).to eq(4)
    end
  end
end
