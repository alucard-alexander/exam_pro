# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#new' do
    it 'should initialize a user with valid attributes' do
      user = build(:user)
      expect(user.first_name).to eq('Test')
      expect(user.last_name).to eq('Test')
      expect(user.phone_number).to eq('1234506789')
    end
  end

  describe '#create' do
    it 'should initialize a user with valid attributes' do
      user = build(:user)
      user.save
      expect(user.id).not_to be_nil
      expect(user.first_name).to eq('Test')
      expect(user.last_name).to eq('Test')
      expect(user.phone_number).to eq('1234506789')
    end
  end

  context '#Validations' do
    describe '#first_name' do
      it 'should invalidate null value' do
        user = build(:user, :missing_first_name)
        user.valid?

        expect(user.errors[:first_name]).to include("can't be blank")
      end

      it 'should invalidate empty string input' do
        user = build(:user, :invalidate_first_name_if_it_is_empty_string)
        user.valid?

        expect(user.errors[:first_name]).to include("can't be blank")
      end

      it 'should invalidate special characters string' do
        user = build(:user, :invalidate_first_name_with_special_characters)
        user.valid?

        expect(user.errors[:first_name]).to include('must contain only alphabets')
      end

      it 'should invalidate single characters string' do
        user = build(:user, :invalid_first_name_single_character)
        user.valid?

        expect(user.errors[:first_name]).to include('is too short (minimum is 2 characters)')
      end
    end

    describe '#last_name' do
      it 'should invalidate null value' do
        user = build(:user, :missing_last_name)
        user.valid?

        expect(user.errors[:last_name]).to include("can't be blank")
      end

      it 'should invalidate empty string input' do
        user = build(:user, :invalidate_last_name_if_it_is_empty_string)
        user.valid?

        expect(user.errors[:last_name]).to include("can't be blank")
      end

      it 'should invalidate special characters string' do
        user = build(:user, :invalidate_last_name_with_special_characters)
        user.valid?

        expect(user.errors[:last_name]).to include('must contain only alphabets')
      end

      it 'should invalidate single characters string' do
        user = build(:user, :invalid_last_name_single_character)
        user.valid?

        expect(user.errors[:last_name]).to include('is too short (minimum is 2 characters)')
      end
    end

    describe '#phone_number' do
      it 'should invalidate null value' do
        user = build(:user, :missing_phone_number)
        user.valid?

        expect(user.errors[:phone_number]).to include("can't be blank")
      end

      it 'should invalidate empty string input' do
        user = build(:user, :invalidate_phone_number_if_it_is_empty_string)
        user.valid?

        expect(user.errors[:phone_number]).to include("can't be blank")
      end

      it 'should invalidate special characters string' do
        user = build(:user, :invalidate_phone_number_with_special_characters)
        user.valid?

        expect(user.errors[:phone_number]).to include('must contain only integers')
      end

      it 'should invalidate alphabet characters string' do
        user = build(:user, :invalidate_phone_number_with_alphabet)
        user.valid?

        expect(user.errors[:phone_number]).to include('must contain only integers')
      end

      it 'should invalidate exceeds 10 characters string' do
        user = build(:user, :invalid_phone_number_for_11_characters)
        user.valid?

        expect(user.errors[:phone_number]).to include('is too long (maximum is 10 characters)')
      end

      it 'should validate if it already exists(Unique)' do
        user = create(:user)
        user = build(:user)
        user.valid?
        expect(user.errors[:phone_number]).to include('has already been taken')
      end
    end
  end
end
