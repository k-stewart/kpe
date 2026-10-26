require 'rails_helper'
require 'whenever'
require 'rake'

RSpec.describe "Happiness metrics" do
  def cron_output
    Whenever::JobList.new(file: Rails.root.join("config", "schedule.rb").to_s).
      generate_cron_output
  end

  before { KaisPterosaurEmporium::Application.load_tasks }

  it "Creates a weekly happiness snapshot" do
    # Set up pterosaurs of various happiness
    happy_pt_1 = create(:pterosaur, :fully_vaccinated)
    happy_pt_2 = create(:pterosaur, :fully_vaccinated)
    happy_pt_3 = create(:pterosaur, :fully_vaccinated)
    lonely_pt = create(:pterosaur, :fully_vaccinated)
    unvaccinated_pts = create_list(:pterosaur, 2)

    create(
      :play_date,
      pterosaurs: [ happy_pt_1, happy_pt_2 ],
      start_time: (Time.now.beginning_of_week + 2.hours),
      end_time: (Time.now.beginning_of_week + 4.hours)
    )
    create(
      :play_date,
      pterosaurs: [ happy_pt_1, happy_pt_3 ],
      start_time: Time.now.beginning_of_week + 48.hours,
      end_time: Time.now.beginning_of_week + 52.hours
    )
    create(
      :play_date,
      pterosaurs: [ happy_pt_2, happy_pt_3 ],
      start_time: Time.now.beginning_of_week + 48.hours,
      end_time: Time.now.beginning_of_week + 52.hours
    )

    # Snapshot generator is scheduled for SUnday at 2am
    expect(cron_output.split("/").first).to eq("0 2 * * 0 ")
    expect(cron_output.split("/").last).to match(/bundle exec rake generate_metrics:happiness/)

    # When snapshot generator runs, it generates the expected snapshot
    expect { Rake::Task['generate_metrics:happiness'].invoke }.
      to change(HappinessSnapshot, :count).by(1)

    last_snapshot = HappinessSnapshot.last

    # records the percentage of happy pterosaurs:
    # 3 happy, 2 with too few play dates, 1 ineligible for play dates
    expect(last_snapshot.percent_happy).to eq(0.5)

    # records the reason for unhappiness, weighted
    last_unhappiness_reasons = last_snapshot.sad_reasons.with_indifferent_access
    expect(last_unhappiness_reasons[:too_few_play_dates]).to eq(1)
    expect(last_unhappiness_reasons[:unvaccinated]).to eq(2)
  end
end
