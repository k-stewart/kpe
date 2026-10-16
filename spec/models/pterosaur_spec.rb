require "rails_helper"

RSpec.describe Pterosaur do
  subject(:pterry) { FactoryBot.build(:pterosaur) }

  it { should belong_to :owner }
  it { should have_and_belong_to_many :play_dates }
  it { should have_many :vaccination_records }
end
