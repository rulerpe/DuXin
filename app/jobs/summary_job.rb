# Job to run summary service
class SummaryJob < ApplicationJob
  queue_as :default

  def perform(user_id, user_language, extracted_text)
    summarized_json = SummaryService.new(extracted_text).call
    ActionCable.server.broadcast("summary_translation_channel_#{user_id}",
                                 { stage: 'summarizing_text_completed', message: 'Summarizing text is complete.',
                                   summarized_json: })
    TranslationJob.perform_later(user_id, user_language, extracted_text, summarized_json)
  end
end
