require "rails_helper"

RSpec.describe VaccinationRecord do
  it { is_expected.to belong_to :pterosaur }

  it { is_expected.to validate_presence_of :name }
end
