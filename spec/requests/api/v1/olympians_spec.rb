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
end
