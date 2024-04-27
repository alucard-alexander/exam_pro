FactoryBot.define do
  sequence(:college_title) { |n| "Computer Science#{n}" }

  factory :exam do
    title { 'Computer Science' }
    college_id { create(:college, title: generate(:college_title)).id }
  end

  # TITLE
  trait :missing_exam_title do
    title {}
  end

  trait :invalidate_exam_title_if_it_is_empty_string do
    title { '' }
  end

  trait :invalidate_exam_title_with_special_characters do
    title { 'Computer Science#1' }
  end

  trait :invalidate_exam_title_with_alphabet_and_number_characters do
    title { 'Computer Science1' }
  end

  trait :invalid_exam_title_single_character do
    title { 'h' }
  end

  # COLLEGE_ID
  trait :missing_college_id do
    college_id {}
  end
end
