require 'langchain'

# Translate the summary with OpenAI GPT
# Using LangChain to format and get result in JSON
class TranslationService
  include ApplicationHelper
  def initialize(user_language, summarized_json)
    @language_name = language_name(user_language)
    @summarized_json = summarized_json
    llm_options = {
      temperature: 0.2,
      modelName: 'gpt-3.5-turbo',
      topP: 1,
      frequencyPenalty: 0.4,
      presencePenalty: 0.4
    }
    @llm = Langchain::LLM::OpenAI.new(api_key: Rails.application.credentials.openai[:api_key], llm_options:)
  end

  def call
    prompt_template = "You are a professional translator, ensuring native fluency and accurate description, immerse yourself in {language} language resources.
    Translate the title, body, and action from English to {language}, ensuring that all names and company names remain untranslated.

    title: {title}
    body: {body}
    action: {action}

    {format_instructions}
    "

    json_schema = {
      type: 'object',
      properties: {
        title: {
          type: 'string',
          description: 'Translate title.'
        },
        body: {
          type: 'string',
          description: 'Translate body.'
        },
        action: {
          type: 'string',
          description: 'Translate action.'
        }
      },
      required: %w[title body action],
      additionalProperties: false
    }
    parser = Langchain::OutputParsers::StructuredOutputParser.from_json_schema(json_schema)
    prompt = Langchain::Prompt::PromptTemplate.new(template: prompt_template,
                                                   input_variables: %w[language title body action
                                                                       format_instructions])
    prompt_text = prompt.format(language: @language_name,
                                title: @summarized_json['title'],
                                body: @summarized_json['body'],
                                action: @summarized_json['action'],
                                format_instructions: parser.get_format_instructions)
    llm_response = @llm.chat(messages: [{ role: 'user',
                                          content: prompt_text }]).completion

    parser.parse(llm_response)
  end
end
