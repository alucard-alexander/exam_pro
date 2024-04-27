FactoryBot.define do
  sequence(:exam_title) { |n| "Computer Science#{n}" }
  factory :exam_window do
    exam_id { create(:exam, title: generate(:exam_title)).id }
    start_time { DATE_TIME_FORMAT }
    end_time { (DateTime.parse(DATE_TIME_FORMAT) + 1.hour).strftime('%Y-%m-%d %H:%M:%S') }
  end

  # START TIME
  trait :missing_exam_window_start_time do
    start_time {}
  end

  trait :invalid_exam_window_start_time_string do
    start_time { '2024-04-27sdfsdf 28:58:14sdf' }
  end

  trait :invalid_exam_window_start_time_empty_string do
    start_time { '' }
  end

  # trait :valid_exam_window_start_time_should_accept_string do
  #   start_time { '2024-04-27T16:21:50+05:30' }
  # end

  # END TIME
  trait :missing_exam_window_end_time do
    end_time {}
  end

  trait :invalid_exam_window_end_time_string do
    end_time { '2024-04-2727sdfsdf 25:58:14sdf' }
  end

  trait :invalid_exam_window_end_time_empty_string do
    end_time { '' }
  end

  # trait :valid_exam_window_end_time_should_accept_string do
  #   end_time { '2024-05-27T16:22:50+05:30' }
  # end

  trait :end_time_lesser_than_start_time do
    end_time { (DateTime.parse(DATE_TIME_FORMAT) - 1.week).strftime('%Y-%m-%d %H:%M:%S') }
  end
end
