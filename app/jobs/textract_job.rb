class TextractJob < ApplicationJob
    queue_as :default

    def perform(user_id, image_path)
        extracted_text = TextractService.new(image_path).call
        ActionCable.server.broadcast("summary_translation_channel_#{user_id}", { message: "text extracted!" })
    end
end