# frozen_string_literal: true
FactoryBot.define do
  factory :user do
    first_name { 'Test' }
    last_name { 'Test' }
    phone_number { '1234506789' }
  end

  # FIRST NAME
  trait :missing_first_name do
    first_name {}
  end

  trait :invalidate_first_name_with_special_characters do
    first_name { 'rachel@#$' }
  end

  trait :invalidate_first_name_if_it_is_empty_string do
    first_name { '' }
  end

  trait :invalid_first_name_single_character do
    first_name { 'r' }
  end

  # LAST NAME
  trait :missing_last_name do
    last_name {}
  end

  trait :invalidate_last_name_with_special_characters do
    last_name { 'rachel@#$' }
  end

  trait :invalidate_last_name_if_it_is_empty_string do
    last_name { '' }
  end

  trait :invalid_last_name_single_character do
    last_name { 'r' }
  end

  # PHONE NUMBER
  trait :missing_phone_number do
    phone_number {}
  end

  trait :invalidate_phone_number_with_special_characters do
    phone_number { '123456789@' }
  end

  trait :invalidate_phone_number_with_alphabet do
    phone_number { '123456789a' }
  end

  trait :invalidate_phone_number_if_it_is_empty_string do
    phone_number { '' }
  end

  trait :invalid_phone_number_for_11_characters do
    phone_number { '12345678901' }
  end
end
