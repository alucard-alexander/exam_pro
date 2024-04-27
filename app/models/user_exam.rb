class UserExam < ApplicationRecord
  # ASSOCIATIONS
  belongs_to :user
  belongs_to :exam
  belongs_to :college

  # VALIDATIONS
  validates :start_time, presence: true
  validate :college_id_belongs_to_exam
  validate :validate_start_time

  private

  def college_id_belongs_to_exam
    return if college_id.blank? || exam.blank?

    errors.add(:college, 'Wrong college selected') if exam.college_id != college_id
  end

  def validate_start_time
    return if exam.blank?

    unless exam.exam_windows.where("start_time <= ? AND end_time >= ?", start_time, start_time).exists?
      errors.add(:start_time, "must be within the exam window")
    end
  end
end
