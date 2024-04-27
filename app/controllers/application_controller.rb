class ApplicationController < ActionController::API
  rescue_from Exception, with: :render_internal_server_error

  def render_internal_server_error(exception)
    ApiRequest.request_log_create(request.original_url, request.method, request.params, 500, exception.message)

    render json: { error: 'Internal Server Error' }, status: :internal_server_error
  end
end
