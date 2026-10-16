FactoryBot.define do
  factory :pterosaur do
    name { Faker::Name.name }
    species { Faker::Creature::Bird.common_name }
    association :owner
  end
end
