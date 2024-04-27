require 'rails_helper'

RSpec.describe College, type: :model do
  describe '#new' do
    it 'should initialize a college with valid attributes' do
      college = build(:college)
      expect(college.title).to eq('Harvard University')
    end
  end

  describe '#create' do
    it 'should initialize a college with valid attributes' do
      college = build(:college)
      college.save
      expect(college.id).not_to be_nil
      expect(college.title).to eq('Harvard University')
    end
  end

  context '#Validations' do
    describe '#title' do
      it 'should invalidate for null value' do
        college = build(:college, :missing_title)

        college.valid?

        expect(college.errors[:title]).to include("can't be blank")
      end

      it 'should invalidate for empty string' do
        college = build(:college, :invalidate_title_if_it_is_empty_string)

        college.valid?

        expect(college.errors[:title]).to include("can't be blank")
      end

      it 'should invalidate for special characters string' do
        college = build(:college, :invalidate_title_with_special_characters)

        college.valid?

        expect(college.errors[:title]).to include('must contain only alphabets and numbers')
      end

      it 'should accept numbers string' do
        college = build(:college, :invalidate_title_with_alphabet_and_number_characters)

        expect(college).to be_valid
      end

      it 'should invalidate if the character count is lesser than 2' do
        college = build(:college, :invalid_title_single_character)

        college.valid?

        expect(college.errors[:title]).to include('is too short (minimum is 2 characters)')
      end

      it 'should validate if it already exists(Unique)' do
        college = create(:college)
        college = build(:college)
        college.valid?
        expect(college.errors[:title]).to include('has already been taken')
      end
    end
  end

  context '#Associations' do
    describe '#college' do
      it 'should have has_many exam_windows' do
        association = described_class.reflect_on_association(:exams)
        expect(association.macro).to eq(:has_many)
      end
    end
  end
end
