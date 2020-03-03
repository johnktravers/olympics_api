FactoryBot.define do
  factory :team do
    country { Faker::WorldCup.team }
  end
end
