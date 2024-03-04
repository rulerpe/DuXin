require 'rails_helper'

RSpec.describe OtpVerificationsController, type: :request do
  describe 'POST /otp/verify' do
    let(:user) { FactoryBot.create(:user, phone_number: '1234567890') }

    context 'when user is not found' do
      it 'returns a user not found error' do
        post otp_verify_path, params: { phone_number: '0000000000', otp_code: '123456' }
        expect(response).to have_http_status(:not_found)
        expect(json['error']).to eq('User not found.')
      end
    end

    context 'when account is temporarily locked' do
      before do
        user.update(locked_at: 5.minutes.ago)
      end

      it 'returns an account locked error' do
        post otp_verify_path, params: { phone_number: user.phone_number, otp_code: '123456' }
        expect(response).to have_http_status(:locked)
        expect(json['error']).to eq('Account temporarily locked.')
      end
    end

    context 'when phone number verification is successful' do
      before do
        allow(OtpVerificationService).to receive(:new).and_return(double(check_verification: true))
      end

      it 'verifies the phone number successfully' do
        post otp_verify_path, params: { phone_number: user.phone_number, otp_code: '123456' }
        expect(response).to have_http_status(:ok)
        expect(json['message']).to eq('Phone number verified successfully.')
      end
    end

    context 'when verification fails' do
      before do
        allow(OtpVerificationService).to receive(:new).and_return(double(check_verification: false))
      end

      it 'increments failed attempts and returns an error' do
        expect do
          post otp_verify_path, params: { phone_number: user.phone_number, otp_code: 'wrong_code' }
        end.to change { user.reload.failed_attempts }.by(1)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['error']).to eq('Verification failed. Please try again.')
      end
    end
  end
end
