require "rails_helper"

RSpec.describe PlayDate do
  let(:play_date) { FactoryBot.build(:play_date) }

  it { is_expected.to have_and_belong_to_many :pterosaurs }
  it { is_expected.to validate_presence_of :start_time }
  it { is_expected.to validate_presence_of :end_time }

  it "must have a start_time after the end_time" do
    play_date = described_class.new(start_time: 5.hours.from_now, end_time: 2.hours.from_now)

    expect(play_date).not_to be_valid
    expect(play_date.errors.full_messages).
      to include("End time must be later than start time")
  end
end
