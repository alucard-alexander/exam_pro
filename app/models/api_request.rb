class ApiRequest < ApplicationRecord
  # EUM
  enum :request_verb, { GET: 0, POST: 1, PATCH: 2, PUT: 3, DELETE: 4 }

  # VALIDATIONS
  validates :url, presence: true
  validates :request_verb, presence: true
  validates :response_status, presence: true
  validates :response_body, presence: true

  def self.request_log_create(url, request_verb, request_body, response_status, response_body)
    create(
      url:,
      request_verb:,
      request_body:,
      response_status:,
      response_body:
    )
  end
end
