class PlayDate < ApplicationRecord
  has_and_belongs_to_many :pterosaurs

  validates_presence_of :start_time
  validates_presence_of :end_time
  validate :end_after_start

  def end_after_start
    errors.add(:end_time, "must be later than start time") unless end_time&.>(start_time)
  end
end
