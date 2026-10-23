FactoryBot.define do
  factory :play_date do
    association :pterosaurs, factory: :pterosaur

    start_time { 3.days_ago }
    end_time { (start_time + 3.hours) }
  end
end
