require 'rails_helper'

RSpec.describe ExamWindow, type: :model do
  describe '#new' do
    it 'should initialize a exam_window with valid attributes' do
      exam = create(:exam)
      exam_window = build(:exam_window, exam_id: exam.id)
      expect(exam_window.start_time).to eq(DateTime.parse('2024-04-27 15:58:14'))
      expect(exam_window.end_time).to eq(DateTime.parse('2024-04-27 15:58:14') + 1.hour)
      expect(exam_window.exam.id).to eq(exam.id)
      expect(exam_window.exam.title).to eq(exam.title)
    end
  end

  describe '#create' do
    it 'should initialize a exam_window with valid attributes' do
      exam = create(:exam)
      exam_window = build(:exam_window, exam_id: exam.id)
      exam_window.save
      expect(exam_window.id).not_to be_nil
      expect(exam_window.start_time).to eq(DateTime.parse('2024-04-27 15:58:14'))
      expect(exam_window.end_time).to eq(DateTime.parse('2024-04-27 15:58:14') + 1.hour)
      expect(exam_window.exam.id).to eq(exam.id)
      expect(exam_window.exam.title).to eq(exam.title)
    end
  end

  context '#Validations' do
    describe 'start_time' do
      it 'should invalidate null value' do
        exam_window = build(:exam_window, :missing_exam_window_start_time)
        exam_window.valid?

        expect(exam_window.errors[:start_time]).to include("can't be blank")
      end

      it 'should invalidate invalid date time string format' do
        exam_window = FactoryBot.build(:exam_window, :invalid_exam_window_start_time_string)
        exam_window.valid?

        expect(exam_window.errors[:start_time]).to include("can't be blank")
      end

      it 'should invalidate empty string' do
        exam_window = build(:exam_window, :invalid_exam_window_start_time_empty_string)
        exam_window.valid?

        expect(exam_window.errors[:start_time]).to include("can't be blank")
      end

      # it 'should invaliddate for 2024-04-27T16:21:50+05:30 string format' do
      #   exam_window = build(:exam_window, :valid_exam_window_start_time_should_accept_string)
      #   exam_window.valid?

      #   expect(exam_window.errors[:start_time]).to include("should be in 'YYYY-MM-DD HH:MM:SS' format")
      # end
    end

    describe 'end_time' do
      it 'should invalidate null value' do
        exam_window = build(:exam_window, :missing_exam_window_end_time)
        exam_window.valid?

        expect(exam_window.errors[:end_time]).to include("can't be blank")
      end

      it 'should invalidate invalid date time string format' do
        exam_window = build(:exam_window, :invalid_exam_window_end_time_string)
        exam_window.valid?

        expect(exam_window.errors[:end_time]).to include("can't be blank")
      end

      it 'should invalidate empty string' do
        exam_window = build(:exam_window, :invalid_exam_window_end_time_empty_string)
        exam_window.valid?

        expect(exam_window.errors[:end_time]).to include("can't be blank")
      end

      # it 'should invalidate for 2024-04-27T16:21:50+05:30 string format' do
      #   exam_window = build(:exam_window, :valid_exam_window_end_time_should_accept_string)
      #   exam_window.valid?

      #   expect(exam_window.errors[:end_time]).to include("should be in 'YYYY-MM-DD HH:MM:SS' format")
      # end

      it 'should invalidate if lesser than start date' do
        exam_window = build(:exam_window, :end_time_lesser_than_start_time)
        exam_window.valid?

        expect(exam_window.errors[:end_time]).to include("must be greater than start date")
      end
    end

    describe 'exam' do
    end
  end
end
