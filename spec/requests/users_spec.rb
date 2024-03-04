RSpec.describe 'Users', type: :request do
  let(:user) { FactoryBot.create(:user) }

  before do
    allow(AuthenticationService).to receive(:get_user_from_token).and_return(user)
    allow(AuthenticationService).to receive(:generate_jwt).and_return('token')
  end
  describe 'GET /user_data' do
    it 'returns data for the current user' do
      get user_data_path
      expect(response).to have_http_status(:ok)
      expect(json).to eq({ 'message' => 'User data', 'user' => user.as_json })
      # Assuming you have a UserSerializer; adjust according to your app's actual response structure
    end
  end

  describe 'PUT /user_data' do
    let(:user) { FactoryBot.create(:user, language: 'en') }
    let(:valid_attributes) { { user: { language: 'fr' } } }

    before do
      allow(AuthenticationService).to receive(:get_user_from_token).and_return(user)
    end

    it 'updates the user and returns success message' do
      put user_data_path, params: valid_attributes
      user.reload
      expect(response).to have_http_status(:ok)
      expect(json['message']).to eq('Update success')
      expect(user.language).to eq('fr')
    end
  end

  describe 'POST /users' do
    let(:valid_attributes) { { user: { phone_number: '+1234567890', language: 'en' } } }
    before do
      twilio_response = double('TwilioResponse', sid: '12345')
      allow_any_instance_of(Twilio::REST::Client).to receive_message_chain(:verify, :v2, :services, :verifications,
                                                                           :create).and_return(twilio_response)
    end
    it 'creates a new user and sends a verification code' do
      expect do
        post users_path, params: valid_attributes
      end.to change(User, :count).by(1)
      expect(response).to have_http_status(:ok)
      expect(json['message']).to eq('Verification code sent. Please verify your phone number.')
    end
  end

  describe 'POST /temp_user' do
    let(:valid_attributes) { { user: { phone_number: 'uuid-from-frontend', language: 'en', user_type: 'TEMP' } } }

    it 'creates a temporary user and sets a cookie' do
      post temp_user_path, params: valid_attributes

      expect(response).to have_http_status(:ok)
      expect(json['message']).to eq('Temp user created.')
    end
  end

  describe 'POST /logout' do
    it 'logs out the user' do
      delete logout_path
      expect(response).to have_http_status(:ok)
      expect(response.cookies[:auth_token]).to be_nil
      expect(json['message']).to eq('Logged out successfully')
    end
  end
end
