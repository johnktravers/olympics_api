require 'rails_helper'

RSpec.describe 'Olympian statistics endpoint', type: :request do
  it 'can get statistics across all olympians' do
    Faker::UniqueGenerator.clear

    create(:olympian, age: 24, sex: 'M', height: 190, weight: 75)
    create(:olympian, age: 35, sex: 'M', height: 160, weight: 92)
    create(:olympian, age: 29, sex: 'M', height: 183, weight: 54)
    create(:olympian, age: 17, sex: 'M', height: 210, weight: 150)
    create(:olympian, age: 24, sex: 'F', height: 150, weight: 45)
    create(:olympian, age: 27, sex: 'F', height: 200, weight: 95)
    create(:olympian, age: 18, sex: 'F', height: 186, weight: 111)
    create(:olympian, age: 31, sex: 'F', height: 171, weight: 82)

    get '/api/v1/olympian_stats'

    expect(response).to be_successful

    stats = JSON.parse(response.body)['olympian_stats']

    expect(stats['total_competing_olympians']).to eq(8)
    expect(stats['average_weight']['unit']).to eq('kg')
    expect(stats['average_weight']['male_olympians']).to eq(92.8)
    expect(stats['average_weight']['female_olympians']).to eq(83.3)
    expect(stats['average_age']).to eq(25.6)
  end
end
