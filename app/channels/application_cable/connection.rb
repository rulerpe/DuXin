module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user || reject_unauthorized_connection
    end

    private

    def find_verified_user
      AuthenticationService.get_user_from_token(
        request.headers['Authorization'],
        cookies.signed[:auth_token],
        request.params
      )
    end
  end
end
