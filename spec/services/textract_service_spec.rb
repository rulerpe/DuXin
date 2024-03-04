require 'rails_helper'

RSpec.describe TextractService do
  describe '#call' do
    let(:image_path) { 'spec/fixtures/files/test_image_letter.jpg' }
    let(:textract_service) { described_class.new(image_path) }
    let(:mock_textract_client) { instance_double(Aws::Textract::Client) }
    let(:mock_textract_response) do
      instance_double(Aws::Textract::Types::DetectDocumentTextResponse,
                      blocks: [
                        Aws::Textract::Types::Block.new(block_type: 'LINE', text: 'This is a line of text.'),
                        Aws::Textract::Types::Block.new(block_type: 'WORD', text: 'This'),
                        Aws::Textract::Types::Block.new(block_type: 'LINE', text: 'Another line of text.')
                      ])
    end

    before do
      allow(Aws::Textract::Client).to receive(:new).and_return(mock_textract_client)
      allow(mock_textract_client).to receive(:detect_document_text).and_return(mock_textract_response)
    end

    it 'extracts and filters text from an image' do
      expected_text = 'This is a line of text. Another line of text.'
      expect(textract_service.call).to eq(expected_text)
    end
  end
end
