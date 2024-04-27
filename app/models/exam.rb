class Exam < ApplicationRecord
  # ASSOCIATIONS
  belongs_to :college
  has_many :exam_windows
  has_many :user_exams
  has_many :users, through: :user_exams

  # VALIDATIONS
  validates :title, presence: true, uniqueness: true, length: { minimum: 2 },
                    format: { with: /\A[a-zA-Z0-9\s]*\z/, message: 'must contain only alphabets and numbers' }
end
