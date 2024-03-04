class OtpVerificationsController < ApplicationController
  skip_before_action :authenticate_request, only: [:verify_user_otp]
  before_action :find_user_by_phone, only: [:verify_user_otp]
  include ActionController::Cookies

  # POST /otp/verify
  def verify_user_otp
    return render_user_locaked if user_locked?
    return verify_with_test_credentials if testing_environment?

    verify_with_otp_service
  end

  # def verify_user_otp
  #   user = User.find_by(phone_number: params[:phone_number])

  #   if user.nil?
  #     render json: { error: 'User not found.' }, status: :not_found
  #     return
  #   end

  #   if user.locked_at? && user.locked_at > 10.minutes.ago
  #     render json: { error: 'Account temporarily locked.' }, status: :locked
  #     return
  #   end

  #   if user.phone_number == ENV['test_phone_number'] and params[:otp_code] == ENV['test_otp_code']
  #     token = assign_token_to_cookie(user.id)
  #     render json: { message: 'Phone number verified successfully.', token:, user: }, status: :ok
  #     return
  #   end

  #   is_verified = OtpVerificationService.new.check_verification(user.phone_number, params[:otp_code])
  #   if is_verified
  #     user.reset_failed_attempts
  #     user.update(verified: true)

  #     # If temp_uuid exist, transfer image record to new account.
  #     transfer_summary_translations(params[:temp_uuid], user) if params[:temp_uuid].present?

  #     token = assign_token_to_cookie(user.id)
  #     render json: { message: 'Phone number verified successfully.', token:, user: }, status: :ok
  #   else
  #     user.increment!(:failed_attempts)
  #     user.lock_account if user.failed_attempts >= 5
  #     render json: { error: 'Verification failed. Please try again.' }, status: :unprocessable_entity
  #   end
  # end

  private

  attr_reader :user

  def find_user_by_phone
    @user = User.find_by(phone_number: params[:phone_number])
    render json: { error: 'User not found.' }, status: :not_found if user.nil?
  end

  def user_locked?
    user.locked_at && user.locked_at > 10.minutes.ago
  end

  def render_user_locaked
    render json: { error: 'Account temporarily locked.' }, status: :locked
  end

  def testing_environment?
    user.phone_number == ENV['test_phone_number'] && params[:otp_code] == ENV['test_otp_code']
  end

  def verify_with_test_credentials
    render_verification_success(assign_token_to_cookie(user.id))
  end

  def verify_with_otp_service
    if OtpVerificationService.new.check_verification(user.phone_number, params[:otp_code])
      handle_verification_success
    else
      handle_verification_failure
    end
  end

  def handle_verification_success
    user.reset_failed_attempts
    user.update(verified: true)
    transfer_summary_translations(params[:temp_uuid], user.id) if params[:temp_uuid].present?
    render_verification_success(assign_token_to_cookie(user.id))
  end

  def handle_verification_failure
    user.increment!(:failed_attempts)
    user.lock_account if user.failed_attempts >= 5
    render json: { error: 'Verification failed. Please try again.' }, status: :unprocessable_entity
  end

  def render_verification_success(token)
    render json: { message: 'Phone number verified successfully.', token:, user: }, status: :ok
  end

  def transfer_summary_translations(source_uuid, target_user_id)
    return unless (temp_user = User.find_by(phone_number: source_uuid))

    User.transaction do
      temp_user.summary_translations.update_all(user_id: target_user_id)
      temp_user.destroy
    end
  end

  def assign_token_to_cookie(user_id)
    token = AuthenticationService.generate_jwt(user_id)
    cookies.signed[:auth_token] =
      { value: token, httponly: true, same_site: :none, secure: true, expires: 1.week.from_now }
    token
  end
end
