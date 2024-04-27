FactoryBot.define do
  factory :api_request do
    url { 'http://localhost:3000' }
    request_verb { 1 }
    request_body {}
    response_status { 200 }
    response_body { { 'test': 'test' } }
  end

  trait :api_request_missing_url do
    url {}
  end

  trait :api_request_missing_request_verb do
    request_verb {}
  end

  trait :api_request_missing_response_status do
    response_status {}
  end

  trait :api_request_missing_response_body do
    response_body {}
  end
end
