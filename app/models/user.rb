class User < ApplicationRecord
  # VALIDATIONS
  validates :first_name, presence: true, length: { minimum: 2 },
                         format: { with: /\A[a-zA-Z]*\z/, message: 'must contain only alphabets' }
  validates :last_name, presence: true, length: { minimum: 2 },
                        format: { with: /\A[a-zA-Z]*\z/, message: 'must contain only alphabets' }
  validates :phone_number, uniqueness: true, presence: true, length: { minimum: 10, maximum: 10 },
                           format: { with: /\A[0-9]*\z/, message: 'must contain only integers' }
end
