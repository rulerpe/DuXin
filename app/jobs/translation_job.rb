# Job to run translation service
class TranslationJob < ApplicationJob
  queue_as :default

  def perform(user_id, user_language, extracted_text, summarized_json)
    translated_json = TranslationService.new(user_language, summarized_json).call
    ActionCable.server.broadcast("summary_translation_channel_#{user_id}",
                                 { stage: 'Translating_text_completed', message: 'Translating text is complete.',
                                   translated_json: })
    StoreProcessedDocumentJob.perform_later(user_id, user_language, extracted_text,
                                            summarized_json, translated_json)
  end
end
