module ApplicationHelper
  def language_name(code)
    I18n.t("languages.#{code}", locale: I18n.locale)
  end
end
