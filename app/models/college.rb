class College < ApplicationRecord
  # VALIDATIONS
  validates :title, presence: true, uniqueness: true, length: { minimum: 2 },
                    format: { with: /\A[a-zA-Z0-9\s]*\z/, message: 'must contain only alphabets and numbers' }
end
