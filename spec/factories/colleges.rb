FactoryBot.define do
  factory :college do
    title { 'Harvard University' }
  end

  # FIRST NAME
  trait :missing_title do
    title {}
  end

  trait :invalidate_title_if_it_is_empty_string do
    title { '' }
  end

  trait :invalidate_title_with_special_characters do
    title { 'Harvard University#1' }
  end

  trait :invalidate_title_with_alphabet_and_number_characters do
    title { 'Harvard University1' }
  end

  trait :invalid_title_single_character do
    title { 'h' }
  end
end
