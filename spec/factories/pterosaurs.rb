FactoryBot.define do
  factory :pterosaur do
    name { Faker::Name.name }
    species { Faker::Creature::Bird.common_name }
    association :owner

    trait :happy do
      :fully_vaccinated
    end

    trait :fully_vaccinated do
      after :create do |pt|
        VaccinationRecord::REQUIRED_VACCINATIONS.each do |vax|
          create :vaccination_record, pterosaur: pt, name: vax, due_date: 1.month.from_now
        end
      end
    end
  end
end
