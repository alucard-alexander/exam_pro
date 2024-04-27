class Api::V1::UserExamsController < ApplicationController
  def create
    user = User.find_by(phone_number: params[:phone_number])
    if user.nil?
      user = User.new(user_params)
      unless user.save
        ApiRequest.request_log_create(request.original_url, request.method, request.params, 400, user.errors)
        return render json: user.errors, status: 400
      end
    end

    user_exam = user.user_exams.new(user_exam_params)
    if user_exam.save
      ApiRequest.request_log_create(request.original_url, request.method, request.params, 200, { user_exam: })
      return render json: { user_exam: }, status: 200
    end

    ApiRequest.request_log_create(request.original_url, request.method, request.params, 400, user.errors)
    render json: user_exam.errors, status: 400
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :phone_number)
  end

  def user_exam_params
    params.permit(:college_id, :exam_id, :start_time)
  end
end
