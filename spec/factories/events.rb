FactoryBot.define do
  factory :event do
    name { Faker::Job.unique.title }
    sport
  end
end
