require 'rails_helper'

RSpec.describe HappinessSnapshot, type: :model do
  it "can be created" do
    expect { described_class.create }.
      to change(described_class, :count).by(1)
  end

  it "can be read" do
    happiness_percent = 0.5
    sad_reasons = { ate_too_much_candy: 3, welzschmerz: 20 }.with_indifferent_access
    snapshot = described_class.create(
      percent_happy: happiness_percent,
      sad_reasons: sad_reasons
    )

    expect(snapshot.percent_happy).to eq(happiness_percent)
    expect(snapshot.sad_reasons).to eq(sad_reasons)
  end
end
