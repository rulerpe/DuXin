require 'rails_helper'

RSpec.describe OtpVerificationService do
  describe '#start_verification' do
    let(:service) { OtpVerificationService.new }
    let(:to) { '+1234567890' }
    let(:verification_sid) { '12345' }

    before do
      twilio_response = double('TwilioResponse', sid: verification_sid)
      allow_any_instance_of(Twilio::REST::Client).to receive_message_chain(:verify, :v2, :services, :verifications,
                                                                           :create).and_return(twilio_response)
    end

    it 'returns a verification SID' do
      expect(service.start_verification(to)).to eq(verification_sid)
    end
  end

  describe '#check_verification' do
    let(:service) { OtpVerificationService.new }
    let(:phone) { '+1234567890' }
    let(:otp_code) { '123456' }

    context 'when verification is successful' do
      before do
        twilio_response = double('TwilioResponse', status: 'approved')
        allow_any_instance_of(Twilio::REST::Client).to receive_message_chain(:verify, :v2, :services,
                                                                             :verification_checks, :create).and_return(twilio_response)
      end

      it 'returns true' do
        expect(service.check_verification(phone, otp_code)).to be true
      end
    end

    context 'when verification fails' do
      before do
        twilio_response = double('TwilioResponse', status: 'pending')
        allow_any_instance_of(Twilio::REST::Client).to receive_message_chain(:verify, :v2, :services,
                                                                             :verification_checks, :create).and_return(twilio_response)
      end

      it 'returns false' do
        expect(service.check_verification(phone, otp_code)).to be false
      end
    end
  end
end
