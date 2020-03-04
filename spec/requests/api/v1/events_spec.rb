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

  it 'can see a list of medalists for a specific event' do
    event = create(:event, name: 'Badminton Women\'s Singles')
    olympians = create_list(:olympian, 4)
    olympians.each_with_index do |olympian, i|
      create(:olympian_event, olympian: olympian, event: event, medal: i)
    end

    get "/api/v1/events/#{event.id}/medalists"

    expect(response).to be_successful

    event = JSON.parse(response.body)

    expect(event['event']).to eq('Badminton Women\'s Singles')
    expect(event['medalists'].length).to eq(3)

    expect(event['medalists'][0]['name']).to eq(olympians[3].name)
    expect(event['medalists'][0]['team']).to eq(olympians[3].team.country)
    expect(event['medalists'][0]['age']).to eq(olympians[3].age)
    expect(event['medalists'][0]['medal']).to eq('Gold')

    expect(event['medalists'][1]['name']).to eq(olympians[2].name)
    expect(event['medalists'][1]['team']).to eq(olympians[2].team.country)
    expect(event['medalists'][1]['age']).to eq(olympians[2].age)
    expect(event['medalists'][1]['medal']).to eq('Silver')

    expect(event['medalists'][2]['name']).to eq(olympians[1].name)
    expect(event['medalists'][2]['team']).to eq(olympians[1].team.country)
    expect(event['medalists'][2]['age']).to eq(olympians[1].age)
    expect(event['medalists'][2]['medal']).to eq('Bronze')
  end

  it 'sees an error message if the event id is invalid' do
    get '/api/v1/events/306/medalists'

    expect(response.status).to eq(400)

    error = JSON.parse(response.body)

    message = 'Invalid event ID. Please try again with an integer between 1 and 305.'
    expect(error['error']).to eq(message)
    expect(error['status']).to eq('400 Bad Request')
  end
end
