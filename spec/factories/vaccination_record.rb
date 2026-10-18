FactoryBot.define do
  factory :vaccination_records do
    name { Faker::Tea.variety }
    due_date { 1.year.from_now }
  end
end
