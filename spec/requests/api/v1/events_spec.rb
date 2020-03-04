require 'rails_helper'

RSpec.describe 'Events endpoint', type: :request do
  before :each do
    Faker::UniqueGenerator.clear
  end

  it 'can see a list of all events by sport' do
    sport_1 = create(:sport, name: 'Badminton')
    sport_2 = create(:sport, name: 'Archery')

    event_1 = create(:event, sport: sport_1, name: 'Badminton Mixed Doubles')
    event_2 = create(:event, sport: sport_1, name: 'Badminton Men\'s Doubles')
    event_3 = create(:event, sport: sport_1, name: 'Badminton Women\'s Singles')
    event_4 = create(:event, sport: sport_2, name: 'Archery Men\'s Team')
    event_5 = create(:event, sport: sport_2, name: 'Arcehry Men\'s Individual')

    get '/api/v1/events'

    expect(response).to be_successful

    events = JSON.parse(response.body)['events']

    expect(events[0]['sport']).to eq(sport_2.name)
    expect(events[0]['events'][0]).to eq(event_5.name)
    expect(events[0]['events'][1]).to eq(event_4.name)

    expect(events[1]['sport']).to eq(sport_1.name)
    expect(events[1]['events'][0]).to eq(event_2.name)
    expect(events[1]['events'][1]).to eq(event_1.name)
    expect(events[1]['events'][2]).to eq(event_3.name)

  end
end
