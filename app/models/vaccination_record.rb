class VaccinationRecord < ApplicationRecord
  belongs_to :pterosaur

  validates_presence_of :name
end
