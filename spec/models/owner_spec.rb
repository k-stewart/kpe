require "rails_helper"

RSpec.describe Owner do
  let(:owner) { FactoryBot.build(:owner) }

  it { is_expected.to have_many :pterosaurs }
end
