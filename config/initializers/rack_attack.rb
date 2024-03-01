# Throttle the number of attempt for OTP login
class Rack::Attack
    throttle('limit OTP login per phone number', limit: 10, period: 60) do |req|
        if req.path == '/verify_user_otp' && req.post?
            req.params['phone_number']
        end
    end
end