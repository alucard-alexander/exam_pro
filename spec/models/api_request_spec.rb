require 'rails_helper'

RSpec.describe ApiRequest, type: :model do
  describe '#new' do
    it 'should initialize a api_request with valid attributes' do
      api_request = build(:api_request)
      expect(api_request.url).to eq('http://localhost:3000')
      expect(api_request.request_verb).to eq('POST')
      expect(api_request.response_status).to eq(200)
      expect(api_request.response_body.to_json).to eq({ 'test': 'test' }.to_json)
    end
  end

  describe '#create' do
    it 'should initialize a api_request with valid attributes' do
      api_request = create(:api_request)
      expect(api_request.id).not_to be_nil
      expect(api_request.url).to eq('http://localhost:3000')
      expect(api_request.request_verb).to eq('POST')
      expect(api_request.response_status).to eq(200)
      expect(api_request.response_body.to_json).to eq({ 'test': 'test' }.to_json)
    end
  end

  context '#Validations' do
    describe '#url' do
      it 'should invalidate null value' do
        api_request = build(:api_request, :api_request_missing_url)
        api_request.valid?

        expect(api_request.errors[:url]).to include("can't be blank")
      end
    end

    describe '#request_verb' do
      it 'should invalidate null value' do
        api_request = build(:api_request, :api_request_missing_request_verb)
        api_request.valid?

        expect(api_request.errors[:request_verb]).to include("can't be blank")
      end
    end

    describe '#response_status' do
      it 'should invalidate null value' do
        api_request = build(:api_request, :api_request_missing_response_status)
        api_request.valid?

        expect(api_request.errors[:response_status]).to include("can't be blank")
      end
    end

    describe '#response_body' do
      it 'should invalidate null value' do
        api_request = build(:api_request, :api_request_missing_response_body)
        api_request.valid?

        expect(api_request.errors[:response_body]).to include("can't be blank")
      end
    end
  end

  describe '#request_log_create' do
    it 'creates a new ApiRequest record for requests' do
      expect do
        create(:api_request)
      end.to change(ApiRequest, :count).by(1)
    end
  end
end
