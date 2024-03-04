require 'rails_helper'

RSpec.describe AuthenticationService do
  describe '.generate_jwt' do
    let(:user_id) { 1 }
    let(:secret_key) { 'mysecretkey' }

    before do
      allow(ENV).to receive(:[]).with('jwt_secret_key').and_return(secret_key)
    end

    it 'generates a valid JWT token' do
      token = described_class.generate_jwt(user_id)
      decoded_token = JWT.decode(token, secret_key, true, { algorithm: 'HS256' })[0]

      expect(decoded_token['user_id']).to eq(user_id)
      expect(decoded_token).to have_key('exp')
    end
  end
  describe '.get_user_from_token' do
    let(:user) { create(:user) }
    let(:token) { 'dummytoken' }
    let(:secret_key) { 'mysecretkey' }

    before do
      allow(ENV).to receive(:[]).with('jwt_secret_key').and_return(secret_key)
      allow(JWT).to receive(:decode).and_return([{ 'user_id' => user.id }])
    end

    it 'returns the user from the token in header' do
      expect(User).to receive(:find).with(user.id).and_return(user)
      result = described_class.get_user_from_token("Bearer #{token}", nil)
      expect(result).to eq(user)
    end

    it 'returns the user from the token in cookie' do
      expect(User).to receive(:find).with(user.id).and_return(user)
      result = described_class.get_user_from_token(nil, token)
      expect(result).to eq(user)
    end
  end

  describe '.token_from_header' do
    it 'extracts the token from the authorization header' do
      auth_header = 'Bearer dummytoken'
      expect(described_class.token_from_header(auth_header)).to eq('dummytoken')
    end

    it 'returns nil if the authorization header is not present' do
      expect(described_class.token_from_header(nil)).to be_nil
    end
  end
end
