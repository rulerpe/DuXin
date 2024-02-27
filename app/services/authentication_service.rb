# A service to get token from header(mobile) or httponly cookie(webapp)
class AuthenticationService
  def self.generate_jwt(user_id)
    payload = { user_id:, exp: 24.hours.from_now.to_i }
    secret_key = Rails.application.credentials.jwt_secret_key
    JWT.encode(payload, secret_key, 'HS256')
  end

  def self.get_user_from_token(auth_headers, auth_cookie_token)
    token = token_from_header(auth_headers) || auth_cookie_token
    decoded = JWT.decode(token, Rails.application.credentials.jwt_secret_key)[0]
    User.find(decoded['user_id'])
  end

  def self.token_from_header(auth_headers)
    auth_headers.split(' ').last if auth_headers.present?
  end
end
