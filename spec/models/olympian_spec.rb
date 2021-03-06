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
      Faker::UniqueGenerator.clear

      olympian = create(:olympian)

      expect(olympian.total_medals_won).to eq(0)

      create_list(:olympian_event, 5, medal: 0, olympian: olympian)
      create_list(:olympian_event, 2, medal: 1, olympian: olympian)
      create(:olympian_event, medal: 2, olympian: olympian)
      create(:olympian_event, medal: 3, olympian: olympian)

      expect(olympian.total_medals_won).to eq(4)
    end
  end

  describe 'class methods' do
    before :each do
      Faker::UniqueGenerator.clear
    end

    it 'youngest_olympians' do
      olympian_1 = create(:olympian, age: 12)
      create_list(:olympian, 4)
      olympian_2 = create(:olympian, age: 12)

      expect(Olympian.youngest_olympians).to eq([olympian_1, olympian_2])
    end

    it 'oldest_olympians' do
      olympian_1 = create(:olympian, age: 63)
      create_list(:olympian, 4)
      olympian_2 = create(:olympian, age: 63)

      expect(Olympian.oldest_olympians).to eq([olympian_1, olympian_2])
    end

    it 'total_competing_olympians' do
      create_list(:olympian, 8)

      expect(Olympian.total_competing_olympians).to eq(8)
    end

    it 'average_weight_by_sex' do
      create(:olympian, sex: 'M', weight: 75)
      create(:olympian, sex: 'M', weight: 92)
      create(:olympian, sex: 'M', weight: 54)
      create(:olympian, sex: 'F', weight: 45)
      create(:olympian, sex: 'F', weight: 95)
      create(:olympian, sex: 'F', weight: 111)

      expect(Olympian.average_weight_by_sex('M').round(2)).to eq(73.67)
      expect(Olympian.average_weight_by_sex('F').round(2)).to eq(83.67)
    end

    it 'average_age' do
      create(:olympian, age: 24)
      create(:olympian, age: 35)
      create(:olympian, age: 29)
      create(:olympian, age: 17)
      create(:olympian, age: 24)

      expect(Olympian.average_age).to eq(25.8)
    end
  end
end
