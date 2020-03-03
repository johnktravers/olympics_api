require 'rails_helper'

RSpec.describe 'Olympians endpoint', type: :request do
  before :each do
    Faker::UniqueGenerator.clear
  end

  it 'can see a list of all olympians' do
    olympian_1 = create(:olympian)
    create_list(:olympian, 2)
    olympian_4 = create(:olympian)

    get '/api/v1/olympians'

    expect(response).to be_successful

    olympians = JSON.parse(response.body)['olympians']

    expect(olympians.length).to eq(4)

    expect(olympians[0]['name']).to eq(olympian_1.name)
    expect(olympians[0]['team']).to eq(olympian_1.team.country)
    expect(olympians[0]['age']).to eq(olympian_1.age)
    expect(olympians[0]['sport']).to eq(olympian_1.sport.name)
    expect(olympians[0]['total_medals_won']).to eq(0)

    expect(olympians[3]['name']).to eq(olympian_4.name)
    expect(olympians[3]['team']).to eq(olympian_4.team.country)
    expect(olympians[3]['age']).to eq(olympian_4.age)
    expect(olympians[3]['sport']).to eq(olympian_4.sport.name)
    expect(olympians[3]['total_medals_won']).to eq(0)
  end

  it 'can see a list of the youngest olympians' do
    olympian_1 = create(:olympian, age: 12)
    create_list(:olympian, 3)
    olympian_2 = create(:olympian, age: 12)

    get '/api/v1/olympians?age=youngest'

    expect(response).to be_successful

    olympians = JSON.parse(response.body)['olympians']

    expect(olympians.length).to eq(2)

    expect(olympians[0]['name']).to eq(olympian_1.name)
    expect(olympians[0]['team']).to eq(olympian_1.team.country)
    expect(olympians[0]['age']).to eq(olympian_1.age)
    expect(olympians[0]['sport']).to eq(olympian_1.sport.name)
    expect(olympians[0]['total_medals_won']).to eq(0)

    expect(olympians[1]['name']).to eq(olympian_2.name)
    expect(olympians[1]['team']).to eq(olympian_2.team.country)
    expect(olympians[1]['age']).to eq(olympian_2.age)
    expect(olympians[1]['sport']).to eq(olympian_2.sport.name)
    expect(olympians[1]['total_medals_won']).to eq(0)
  end

  it 'sees an error message if the age parameter is invalid' do
    get '/api/v1/olympians?age=middle'

    expect(response.status).to eq(400)

    error = JSON.parse(response.body)

    message = "Invalid request. Please enter either 'youngest' or 'oldest' for the age parameter."
    expect(error['error']).to eq(message)
    expect(error['status']).to eq('400 Bad Request')
  end
end
