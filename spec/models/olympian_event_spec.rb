require 'rails_helper'

RSpec.describe OlympianEvent, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:medal).allow_nil }
  end

  describe 'relationships' do
    it { should belong_to :olympian }
    it { should belong_to :event }
  end

  describe 'medals' do
    it 'can have no medal' do
      olympian_event = create(:olympian_event)

      expect(olympian_event.medal).to eq(nil)
      expect(olympian_event.medal?).to eq(false)
    end

    it 'can have a bronze medal' do
      olympian_event = create(:olympian_event, medal: 1)

      expect(olympian_event.medal).to eq('bronze')
      expect(olympian_event.medal?).to eq(true)
      expect(olympian_event.bronze?).to eq(true)
    end

    it 'can have a silver medal' do
      olympian_event = create(:olympian_event, medal: 2)

      expect(olympian_event.medal).to eq('silver')
      expect(olympian_event.medal?).to eq(true)
      expect(olympian_event.silver?).to eq(true)
    end

    it 'can have a gold medal' do
      olympian_event = create(:olympian_event, medal: 3)

      expect(olympian_event.medal).to eq('gold')
      expect(olympian_event.medal?).to eq(true)
      expect(olympian_event.gold?).to eq(true)
    end
  end
end
