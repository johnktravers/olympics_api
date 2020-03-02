FactoryBot.define do
  factory :event do
    name { Faker::Job.title }
    sport
  end
end
