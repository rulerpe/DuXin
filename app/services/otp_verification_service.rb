class OtpVerificationService
  CHANNEL = 'sms'.freeze
  def initialize
    account_id = ENV['twilio_account_sid']
    auth_token = ENV['twilio_auth_token']
    @service_sid = ENV['twilio_service_sid']
    @twilio_client = Twilio::REST::Client.new(account_id, auth_token)
  end

  def start_verification(to)
    verification = @twilio_client.verify.v2.services(service_sid).verifications.create(to:, channel: CHANNEL)
    verification.sid
  rescue Twilio::REST::RestError => e
    Rails.logger.error "OTP verification start error: #{e.message}"
    nil
  end

  def check_verification(phone, otp_code)
    verification_check = @twilio_client.verify.v2.services(service_sid).verification_checks.create(to: phone,
                                                                                                   code: otp_code)
    verification_check.status == 'approved'
  rescue Twilio::REST::RestError => e
    log_verification_error(e)
    false
  end

  private

  def log_verification_error(error)
    message = case error.code
              when 20_404
                'Verification failed: OTP code is incorrect or expired.'
              else
                "An error occurred: #{error.message}"
              end
    Rails.logger.error message
  end
end
