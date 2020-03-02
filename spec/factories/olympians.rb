FactoryBot.define do
  factory :olympian do
    name { Faker::Name.name }
    age { Faker::Number.between(from: 13, to: 62) }
    sex { Faker::Gender.short_binary_type.capitalize }
    height { Faker::Number.between(from: 150, to: 210) }
    weight { Faker::Number.between(from: 40, to: 120) }
    team
    sport
  end
end
