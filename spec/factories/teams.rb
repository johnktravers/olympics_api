FactoryBot.define do
  factory :team do
    country { Faker::WorldCup.unique.team }
  end
end
