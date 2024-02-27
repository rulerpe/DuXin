require 'aws-sdk-textract'

class TextractService
    def initialize(image_path)
        @image_path = image_path
    end

    def call()
        textract_client = Aws::Textract::Client.new(
            access_key_id: Rails.application.credentials.aws[:access_key_id],
            secret_access_key: Rails.application.credentials.aws[:secret_access_key],
            region: Rails.application.credentials.aws[:region]
        )
        file = File.read(@image_path)
        response = textract_client.detect_document_text({
            document: {
                bytes: file,
            }
        })
        response.to_h
    end
end