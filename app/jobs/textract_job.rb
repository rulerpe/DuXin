# Job to run text extract service
class TextractJob < ApplicationJob
  queue_as :default

  def perform(user_id, user_language, image_path)
    ActionCable.server.broadcast("summary_translation_channel_#{user_id}",
                                 { stage: 'extracting_text', message: 'Extracting text from image.' })
    extracted_text = TextractService.new(image_path).call

    SummaryJob.perform_later(user_id, user_language, extracted_text)
  end
end
