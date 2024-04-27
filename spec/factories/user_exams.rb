FactoryBot.define do
  sequence(:phone_number) { |n| "987654321#{n}" }
  sequence(:user_exam_college_title) { |n| "Harvard University#{n}" }
  sequence(:user_exam_exam_title) { |n| "Computer Science#{n}" }
  factory :user_exam do
    user_id { create(:user, phone_number: generate(:phone_number)).id }
    exam_id { create(:exam, exam_title: generate(:user_exam_exam_title)).id }
    college_id { create(:college, college_title: generate(:user_exam_college_title)).id }
    start_time { DATE_TIME_FORMAT }
  end

  # USER ID
  trait :user_exam_missing_user_id do
    user_id {}
  end

  # EXAM ID
  trait :user_exam_missing_exam_id do
    exam_id {}
  end

  # COLLEGE ID
  trait :user_exam_missing_college_id do
    college_id {}
  end

  # START TIME
  trait :user_exam_missing_start_time do
    start_time {}
  end
end
