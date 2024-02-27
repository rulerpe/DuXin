class SummaryTranslationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "summary_translation_channel_#{current_user.id}"
  end

  def unsubscribed
  end

end
