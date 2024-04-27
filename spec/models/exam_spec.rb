require 'rails_helper'

RSpec.describe Exam, type: :model do
  describe '#new' do
    it 'should initialize a college with valid attributes' do
      college = create(:college)
      exam = build(:exam, college_id: college.id)
      expect(exam.title).to eq('Computer Science')
      expect(exam.college_id).to eq(college.id)
      expect(exam.college.title).to eq(college.title)
    end
  end

  describe '#create' do
    it 'should initialize a college with valid attributes' do
      college = create(:college)
      exam = build(:exam, college_id: college.id)
      exam.save
      expect(exam.id).not_to be_nil
      expect(exam.title).to eq('Computer Science')
      expect(exam.college_id).to eq(college.id)
      expect(exam.college.title).to eq(college.title)
    end
  end

  context '#Validations' do
    describe '#title' do
      it 'should invalidate for null value' do
        exam = build(:exam, :missing_exam_title)
        exam.valid?

        expect(exam.errors[:title]).to include("can't be blank")
      end

      it 'should invalidate for empty string' do
        exam = build(:exam, :invalidate_exam_title_if_it_is_empty_string)
        exam.valid?

        expect(exam.errors[:title]).to include("can't be blank")
      end

      it 'should invalidate for special characters string' do
        exam = build(:exam, :invalidate_exam_title_with_special_characters)
        exam.valid?

        expect(exam.errors[:title]).to include('must contain only alphabets and numbers')
      end

      it 'should accept numbers string' do
        exam = build(:exam, :invalidate_exam_title_with_alphabet_and_number_characters)

        expect(exam).to be_valid
      end

      it 'should invalidate if the character count is lesser than 2' do
        exam = build(:exam, :invalid_exam_title_single_character)
        exam.valid?

        expect(exam.errors[:title]).to include('is too short (minimum is 2 characters)')
      end

      it 'should validate if it already exists(Unique)' do
        exam = create(:exam)
        exam = build(:exam)
        exam.valid?
        expect(exam.errors[:title]).to include('has already been taken')
      end
    end

    describe '#college' do
      it 'should invalidate for null value' do
        exam = build(:exam, :missing_college_id)
        exam.valid?

        expect(exam.errors[:college]).to include('must exist')
      end
    end
  end

  context '#Associations' do

    describe '#exam' do

      it 'should belongs to college' do
        association = described_class.reflect_on_association(:college)
        expect(association.macro).to eq(:belongs_to)
      end

      it 'should have has_many exam_windows' do
        association = described_class.reflect_on_association(:exam_windows)
        expect(association.macro).to eq(:has_many)
      end

      it 'should have has_many user_exams' do
        association = described_class.reflect_on_association(:user_exams)
        expect(association.macro).to eq(:has_many)
      end

      it 'should have has_many users through user_exams' do
        association = described_class.reflect_on_association(:users)
        expect(association.options[:through]).to eq(:user_exams)
      end
    end
  end
end
