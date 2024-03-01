class OtpVerificationsController < ApplicationController
  skip_before_action :authenticate_request, only: [:verify_user_otp]
  include ActionController::Cookies

  def verify_user_otp
    user = User.find_by(phone_number: params[:phone_number])

    if user.nil?
      render json: { error: 'User not found.' }, status: :not_found
      return
    end

    if user.locked_at? && user.locked_at > 10.minutes.ago
      render json: { error: 'Account temporarily locked.' }, status: :locked
      return
    end

    is_verified = OtpVerificationService.new.check_verification(user.phone_number, params[:otp_code])
    if is_verified
      user.reset_failed_attempts
      user.update(verified: true)

      # If temp_uuid exist, transfer image record to new account.
      transfer_summary_translations(params[:temp_uuid], user) if params[:temp_uuid].present?

      token = AuthenticationService.generate_jwt(user.id)
      cookies.signed[:auth_token] =
        { value: token, httponly: true, same_site: :none, secure: true, expires: 1.week.from_now }
      render json: { message: 'Phone number verified successfully.', token:, user: }, status: :ok
    else
      user.increment!(:failed_attempts)
      user.lock_account if user.failed_attempts >= 5
      render json: { error: 'Verification failed. Please try again.' }, status: :unprocessable_entity
    end
  end

  private

  def transfer_summary_translations(source_uuid, target_user)
    User.transaction do
      temp_user = User.find_by(phone_number: source_uuid)
      temp_user.summary_translations.update_all(user_id: target_user.id)
      temp_user.destroy
    end
  end
end
