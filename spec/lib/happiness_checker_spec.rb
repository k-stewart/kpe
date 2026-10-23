require 'rails_helper'

RSpec.describe HappinessChecker do
  let(:last_snapshot) { HappinessSnapshot.last }

  it "creates a snapshot" do
    expect { described_class.calculate }.to change(HappinessSnapshot, :count).by(1)
  end

  context "when all pterosaurs are happy" do
    let!(:happy_pt_1) { create(:pterosaur, :fully_vaccinated) }
    let!(:happy_pt_2) { create(:pterosaur, :fully_vaccinated) }

    before do
      create(
        :play_date,
        pterosaurs: [ happy_pt_1, happy_pt_2 ],
        start_time: (Time.now.beginning_of_week + 2.hours),
        end_time: (Time.now.beginning_of_week + 4.hours)
      )

      create(
        :play_date,
        pterosaurs: [ happy_pt_1, happy_pt_2 ],
        start_time: Time.now.beginning_of_week + 48.hours,
        end_time: Time.now.beginning_of_week + 52.hours
      )

      described_class.calculate
    end

    it "records the percentage of happy pterosaurs" do
      expect(last_snapshot.percent_happy).to eq(1.0)
    end

    it "records no reasons for misery" do
      expect(last_snapshot.sad_reasons["too_few_play_dates"]).to eq(0)
      expect(last_snapshot.sad_reasons["unvaccinated"]).to eq(0)
    end
  end

  context "when some pterosaurs are unhappy" do
    let!(:happy_pt_1) { create(:pterosaur, :fully_vaccinated) }
    let!(:happy_pt_2) { create(:pterosaur, :fully_vaccinated) }
    let!(:lonely_pts) { create_list(:pterosaur, 2, :fully_vaccinated) }
    let!(:unvaccinated_pt) { create(:pterosaur) }

    before do
      create(
        :play_date,
        pterosaurs: [ happy_pt_1, happy_pt_2 ],
        start_time: (Time.now.beginning_of_week + 2.hours),
        end_time: (Time.now.beginning_of_week + 4.hours)
      )

      create(
        :play_date,
        pterosaurs: [ happy_pt_1, happy_pt_2 ],
        start_time: Time.now.beginning_of_week + 48.hours,
        end_time: Time.now.beginning_of_week + 52.hours
      )

      described_class.calculate
    end

    it "records the percentage of happy pterosaurs" do
      expect(last_snapshot.percent_happy).to eq(0.6)
    end

    it "records all the reasons for misery" do
      expect(last_snapshot.sad_reasons.keys).to match_array(
        %w[too_few_play_dates unvaccinated]
      )
    end

    it "records a pterosaur with over due vaccinations" do
      expect(last_snapshot.sad_reasons["unvaccinated"]).to eq(1)
    end

    it "records a pterosaur with too few play dates" do
      expect(last_snapshot.sad_reasons["too_few_play_dates"]).to eq(2)
    end
  end
end
