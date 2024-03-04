# Job to run translation service
class TranslationJob < ApplicationJob
  queue_as :default

  def perform(user_id, user_language, extracted_text, summarized_json)
    ActionCable.server.broadcast("summary_translation_channel_#{user_id}",
                                 { stage: 'translating_text', message: 'Translating text.' })
    translated_json = TranslationService.new(user_language, summarized_json).call

    StoreProcessedDocumentJob.perform_later(user_id, user_language, extracted_text,
                                            summarized_json, translated_json)
  rescue StandardError => e
    ActionCable.server.broadcast("summary_translation_channel_#{user_id}",
                                 { stage: 'error', message: "An error occurred: #{e.message}" })
  end
end
