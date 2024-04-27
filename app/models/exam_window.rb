class ExamWindow < ApplicationRecord
  # ASSOCIATIONS
  belongs_to :exam

  # VALIDATIONS
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_time_greater_than_start_time


  private

  def end_time_greater_than_start_time
    return if end_time.blank? || start_time.blank?
    errors.add(:end_time, "must be greater than start date") if end_time <= start_time
  end
end
