# Job to run summary service
class SummaryJob < ApplicationJob
  queue_as :default

  def perform(user_id, user_language, extracted_text)
    ActionCable.server.broadcast("summary_translation_channel_#{user_id}",
                                 { stage: 'summarizing_text', message: 'Summarizing text.' })
    summarized_json = SummaryService.new(extracted_text).call

    TranslationJob.perform_later(user_id, user_language, extracted_text, summarized_json)
  end
end
