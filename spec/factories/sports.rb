FactoryBot.define do
  factory :sport do
    name { Faker::Job.unique.field }
  end
end
