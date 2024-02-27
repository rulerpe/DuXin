class ApplicationController < ActionController::API
    before_action :authenticate_request
    include ActionController::Cookies

    private

    def authenticate_request
        begin
            @current_user = AuthenticationService.get_user_from_token(request.headers['Authorization'], cookies.signed[:auth_token])
        rescue ActiveRecord::RecordNotFound => e
            render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: { errors: e.message }, status: :unauthorized
        end
    end
    
end
