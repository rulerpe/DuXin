class OtpVerificationService
  def initialize
    account_id = Rails.application.credentials.twilio[:account_sid]
    auth_token = Rails.application.credentials.twilio[:auth_token]
    @twilio_client = Twilio::REST::Client.new(account_id, auth_token)
  end

  def start_verification(to)
    channel = 'sms'
    service_sid = Rails.application.credentials.twilio[:service_sid]
    verification = @twilio_client.verify.v2.services(service_sid).verifications.create(to:, channel:)
    verification.sid
  end

  def check_verification(phone, otp_code)
    service_sid = Rails.application.credentials.twilio[:service_sid]
    begin
      verification_check = @twilio_client.verify.v2.services(service_sid).verification_checks.create(to: phone,
                                                                                                     code: otp_code)
      verification_check.status == 'approved'
    rescue Twilio::REST::RestError => e
      if e.code == 20_404
        puts 'Verification failed: OTP code is incorrect or expired.'
        false
      else
        puts "An error occurred: #{e.message}"
        false
      end
    end
  end
end
