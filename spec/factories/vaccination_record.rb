FactoryBot.define do
  factory :vaccination_record do
    association :pterosaur
    name { Faker::Tea.variety }
    due_date { 1.year.from_now }
  end
end
