class VaccinationRecord < ApplicationRecord
  REQUIRED_VACCINATIONS = %w[TrexDAP MesosaurMRP].freeze

  belongs_to :pterosaur

  validates_presence_of :name
end
