# Store the extracted text, summay, and translation to database
class StoreProcessedDocumentJob < ApplicationJob
  queue_as :default

  def perform(user_id, user_language, extracted_text, summarized_json, translated_json)
    user = User.find(user_id)
    user.summary_translations.create(
      original_title: summarized_json['title'],
      original_body: summarized_json['body'],
      original_action: summarized_json['action'],
      translated_title: translated_json['title'],
      translated_body: translated_json['body'],
      translated_action: translated_json['action'],
      extracted_text:,
      translation_language: user_language
    )
    ActionCable.server.broadcast("summary_translation_channel_#{user_id}",
                                 { stage: 'summary_translation_completed', message: 'Summary translation completed.',
                                   translated_json: })
  rescue StandardError => e
    ActionCable.server.broadcast("summary_translation_channel_#{user_id}",
                                 { stage: 'error',
                                   message: "An error occurred: #{e.message}" })
  end
end
