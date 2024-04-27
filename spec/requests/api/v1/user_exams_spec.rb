require 'rails_helper'

RSpec.describe 'Api::V1::UserExamsController', type: :request do
  describe '#POST /create' do
    it 'should create user exam with valid params in user exam controller' do
      user = create(:user)
      college = create(:college)
      exam = create(:exam, college_id: college.id)
      create(:exam_window, exam_id: exam.id, start_time: DATE_TIME_FORMAT,
                           end_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.week).strftime('%Y-%m-%d %H:%M:%S'))

      post '/api/v1/user_exams/create',
           params: {
             **user.attributes,
             college_id: college.id,
             exam_id: exam.id,
             start_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.day).strftime('%Y-%m-%d %H:%M:%S')
           }, as: :json
      expect(response.status).to eq(200)
    end

    it 'should create user exam with valid params in user exam controller if the user is not registered' do
      user = build(:user)
      college = create(:college)
      exam = create(:exam, college_id: college.id)
      create(:exam_window, exam_id: exam.id, start_time: DATE_TIME_FORMAT,
                           end_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.week).strftime('%Y-%m-%d %H:%M:%S'))

      post '/api/v1/user_exams/create',
           params: {
             **user.attributes,
             college_id: college.id,
             exam_id: exam.id,
             start_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.day).strftime('%Y-%m-%d %H:%M:%S')
           }, as: :json
      expect(response.status).to eq(200)
    end

    it 'should not create user exam if college_id is not present in the database' do
      user = build(:user)
      college = create(:college)
      exam = create(:exam, college_id: college.id)
      create(:exam_window, exam_id: exam.id, start_time: DATE_TIME_FORMAT,
                           end_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.week).strftime('%Y-%m-%d %H:%M:%S'))

      post '/api/v1/user_exams/create',
           params: {
             **user.attributes,
             college_id: college.id + 1,
             exam_id: exam.id,
             start_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.day).strftime('%Y-%m-%d %H:%M:%S')
           }, as: :json
      expect(response.status).to eq(400)
    end

    it 'should not create user exam if college_id is different from user_exam.college_id and exam.college_id' do
      user = build(:user)
      college = create(:college)
      exam = create(:exam, college_id: college.id)
      create(:exam_window, exam_id: exam.id, start_time: DATE_TIME_FORMAT,
                           end_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.week).strftime('%Y-%m-%d %H:%M:%S'))
      exam = create(:exam, title: 'MIT')

      post '/api/v1/user_exams/create',
           params: {
             **user.attributes,
             college_id: college.id,
             exam_id: exam.id,
             start_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.day).strftime('%Y-%m-%d %H:%M:%S')
           }, as: :json
      expect(response.status).to eq(400)
    end

    it 'should not create user exam if exam id is not present in the database' do
      user = build(:user)
      college = create(:college)
      exam = create(:exam, college_id: college.id)
      create(:exam_window, exam_id: exam.id, start_time: DATE_TIME_FORMAT,
                           end_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.week).strftime('%Y-%m-%d %H:%M:%S'))

      post '/api/v1/user_exams/create',
           params: {
             **user.attributes,
             college_id: college.id,
             exam_id: exam.id + 1,
             start_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.day).strftime('%Y-%m-%d %H:%M:%S')
           }, as: :json
      expect(response.status).to eq(400)
    end

    it 'should not create user exam if start_time does not fall within exams time window' do
      user = build(:user)
      college = create(:college)
      exam = create(:exam, college_id: college.id)
      create(:exam_window, exam_id: exam.id, start_time: DATE_TIME_FORMAT,
                           end_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.week).strftime('%Y-%m-%d %H:%M:%S'))

      post '/api/v1/user_exams/create',
           params: {
             **user.attributes,
             college_id: college.id,
             exam_id: exam.id,
             start_time: (DateTime.parse(DATE_TIME_FORMAT) - 1.day).strftime('%Y-%m-%d %H:%M:%S')
           }, as: :json
      expect(response.status).to eq(400)
    end

    it 'should not create user exam if user few params are missing' do
      college = create(:college)
      exam = create(:exam, college_id: college.id)
      create(:exam_window, exam_id: exam.id, start_time: DATE_TIME_FORMAT,
                           end_time: (DateTime.parse(DATE_TIME_FORMAT) + 1.week).strftime('%Y-%m-%d %H:%M:%S'))

      post '/api/v1/user_exams/create',
           params: {
             first_name: 'Test',
             college_id: college.id,
             exam_id: exam.id,
             start_time: (DateTime.parse(DATE_TIME_FORMAT) - 1.day).strftime('%Y-%m-%d %H:%M:%S')
           }, as: :json
      expect(response.status).to eq(400)
    end
  end
end
