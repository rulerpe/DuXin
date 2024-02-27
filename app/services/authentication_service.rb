class AuthenticationService
    def self.generate_jwt(user_id)
        payload = { user_id: user_id, exp: 24.hours.from_now.to_i }
        secret_key = Rails.application.credentials.jwt_secret_key
        JWT.encode(payload, secret_key, 'HS256')
    end

    def self.get_user_from_token(authHeaders, authCookieToken)
        token = token_from_header(authHeaders) ||  authCookieToken
        decoded = JWT.decode(token, Rails.application.credentials.jwt_secret_key)[0]
        current_user = User.find(decoded['user_id'])
        current_user
    end

    private
    
    def self.token_from_header(authHeaders)
        authHeaders.split(' ').last if authHeaders.present?
    end
end