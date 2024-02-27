# Job to run text extract service
class TextractJob < ApplicationJob
  queue_as :default

  def perform(user_id, user_language, image_path)
    extracted_text = TextractService.new(image_path).call
    ActionCable.server.broadcast("summary_translation_channel_#{user_id}",
                                 { stage: 'text_extraction_completed', message: 'Text extraction is complete.',
                                   extracted_text: })
    SummaryJob.perform_later(user_id, user_language, extracted_text)
  end
end
