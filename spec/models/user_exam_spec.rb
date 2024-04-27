require 'rails_helper'

RSpec.describe UserExam, type: :model do
  describe '#new' do
    it 'should initialize a user_exams with valid attributes' do
      user = create(:user)
      college = create(:college)
      exam = create(:exam, college_id: college.id)
      exam_window = create(:exam_window, exam_id: exam.id, start_time: DATE_TIME_FORMAT, end_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.week).strftime('%Y-%m-%d %H:%M:%S'))
      user_exam = build(:user_exam, college_id: college.id, exam_id: exam.id, user_id: user.id,
                                    start_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.day).strftime('%Y-%m-%d %H:%M:%S'))

      expect(user_exam.user_id).to eq(user.id)
      expect(user_exam.college_id).to eq(college.id)
      expect(user_exam.exam_id).to eq(exam.id)
      expect(user_exam.start_time).to eq((DateTime.parse(DATE_TIME_FORMAT) + 1.day))
    end
  end

  describe '#create' do
    it 'should initialize a user with valid attributes' do
      user = create(:user)
      college = create(:college)
      exam = create(:exam, college_id: college.id)
      exam_window = create(:exam_window, exam_id: exam.id, start_time: DATE_TIME_FORMAT, end_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.week).strftime('%Y-%m-%d %H:%M:%S'))
      user_exam = create(:user_exam, college_id: college.id, exam_id: exam.id, user_id: user.id,
                                     start_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.day).strftime('%Y-%m-%d %H:%M:%S'))

      expect(user_exam.id).not_to be_nil
      expect(user_exam.user_id).to eq(user.id)
      expect(user_exam.college_id).to eq(college.id)
      expect(user_exam.exam_id).to eq(exam.id)
      expect(user_exam.start_time).to eq((DateTime.parse(DATE_TIME_FORMAT) + 1.day))
    end
  end

  context '#Validations' do
    describe '#user' do
      it 'should invalidate for null value' do
        college = create(:college)
        exam = create(:exam, college_id: college.id)
        exam_window = create(:exam_window, exam_id: exam.id, start_time: DATE_TIME_FORMAT, end_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.week).strftime('%Y-%m-%d %H:%M:%S'))
        user_exam = build(:user_exam, :user_exam_missing_user_id, college_id: college.id, exam_id: exam.id,
                                                                  start_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.day).strftime('%Y-%m-%d %H:%M:%S'))
        user_exam.valid?

        expect(user_exam.errors[:user]).to include('must exist')
      end
    end

    describe '#exam' do
      it 'should invalidate for null value' do
        user = create(:user)
        college = create(:college)
        user_exam = build(:user_exam, :user_exam_missing_exam_id, college_id: college.id, user_id: user.id,
                                                                  start_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.day).strftime('%Y-%m-%d %H:%M:%S'))

        user_exam.valid?

        expect(user_exam.errors[:exam]).to include('must exist')
      end
    end

    describe '#college' do
      it 'should invalidate for null value' do
        user = create(:user)
        college = create(:college)
        exam = create(:exam, college_id: college.id)
        exam_window = create(:exam_window, exam_id: exam.id, start_time: DATE_TIME_FORMAT, end_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.week).strftime('%Y-%m-%d %H:%M:%S'))
        user_exam = build(:user_exam, :user_exam_missing_college_id, exam_id: exam.id, user_id: user.id,
                                                                     start_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.day).strftime('%Y-%m-%d %H:%M:%S'))

        user_exam.valid?

        expect(user_exam.errors[:college]).to include('must exist')
      end
    end

    describe '#start_time' do
      it 'should invalidate for null value' do
        user = create(:user)
        college = create(:college)
        exam = create(:exam, college_id: college.id)
        exam_window = create(:exam_window, exam_id: exam.id, start_time: DATE_TIME_FORMAT, end_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.week).strftime('%Y-%m-%d %H:%M:%S'))
        user_exam = build(:user_exam, :user_exam_missing_start_time, college_id: college.id, exam_id: exam.id,
                                                                     user_id: user.id)

        user_exam.valid?

        expect(user_exam.errors[:start_time]).to include("can't be blank")
      end

      it 'should invalidate if exam exists and does not belongs to the college' do
        user = create(:user)
        college = create(:college)
        exam = create(:exam, college_id: college.id)
        college = create(:college, title: 'MIT')
        exam_window = create(:exam_window, exam_id: exam.id, start_time: DATE_TIME_FORMAT, end_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.week).strftime('%Y-%m-%d %H:%M:%S'))
        user_exam = build(:user_exam, college_id: college.id, exam_id: exam.id, user_id: user.id,
                                      start_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.day).strftime('%Y-%m-%d %H:%M:%S'))
        
        user_exam.valid?

        expect(user_exam.errors[:college]).to include("Wrong college selected")
      end

      it 'should invalidate if start_time is not in the exam window' do
        user = create(:user)
        college = create(:college)
        exam = create(:exam, college_id: college.id)
        exam_window = create(:exam_window, exam_id: exam.id, start_time: DATE_TIME_FORMAT, end_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.week).strftime('%Y-%m-%d %H:%M:%S'))
        user_exam = build(:user_exam, college_id: college.id, exam_id: exam.id, user_id: user.id,
                                      start_time: (DateTime.parse(DATE_TIME_FORMAT) - 1.day).strftime('%Y-%m-%d %H:%M:%S'))
        
        user_exam.valid?

        expect(user_exam.errors[:start_time]).to include("must be within the exam window")
      end
    end
  end

  context '#Associations' do
    describe '#user_exams' do
      it 'should belongs to user' do
        association = described_class.reflect_on_association(:user)
        expect(association.macro).to eq(:belongs_to)
      end

      it 'should belongs to exam' do
        association = described_class.reflect_on_association(:exam)
        expect(association.macro).to eq(:belongs_to)
      end

      it 'should belongs to college' do
        association = described_class.reflect_on_association(:college)
        expect(association.macro).to eq(:belongs_to)
      end
    end
  end
end
