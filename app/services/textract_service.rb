require 'aws-sdk-textract'

# Initialzie AWS textract, to extract text from image,
# and filter the text to more narrtive text.
class TextractService
  def initialize(image_path)
    @image_path = image_path
    @textract_client = Aws::Textract::Client.new(
      access_key_id: ENV['aws_access_key_id'],
      secret_access_key: ENV['aws_secret_access_key'],
      region: ENV['aws_region']
    )
  end

  def call
    file = File.read(@image_path)
    response = @textract_client.detect_document_text({
                                                       document: {
                                                         bytes: file
                                                       }
                                                     })

    filter_blocks(response.blocks)
  end

  private

  def filter_blocks(blocks)
    blocks.select { |block| block.block_type == 'LINE' }.map(&:text).join(' ')
  end
end
