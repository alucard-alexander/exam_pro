class Api::V1::UserExamsController < ApplicationController
  def create
    user = User.find_by(phone_number: params[:phone_number])
    if user.nil?
      user = User.new(user_params)
      return render json: user.errors, status: 400 unless user.save
    end

    user_exam = user.user_exams.new(user_exam_params)
    return render json: { user_exam: }, status: 200 if user_exam.save

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
