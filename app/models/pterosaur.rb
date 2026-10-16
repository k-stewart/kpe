class Pterosaur < ApplicationRecord
  belongs_to :owner
  has_and_belongs_to_many :play_dates

  has_many :play_dates
  has_many :vaccination_records
end
