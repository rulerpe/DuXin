require 'rails_helper'

RSpec.describe 'Images', type: :request do
  let(:user) { FactoryBot.create(:user) }

  before do
    allow(AuthenticationService).to receive(:get_user_from_token).and_return(user)
  end

  describe 'POST /upload_image' do
    let(:file) do
      fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test_image_letter.jpg'), 'image/jpg')
    end

    it 'uploads the image and processes it successfully' do
      allow(TextractJob).to receive(:perform_later).and_return(true)

      post upload_image_path, params: { image: file }

      expect(response).to have_http_status(:ok)
      expect(json['message']).to eq('Image uploaded and processed successfully.')
      expect(TextractJob).to have_received(:perform_later).with(user.id, user.language, anything)
    end

    it 'returns an error when no image file is provided' do
      post upload_image_path

      expect(response).to have_http_status(:unprocessable_entity)
      expect(json['error']).to eq('No image file provided.')
    end
  end
end
