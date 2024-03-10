require 'langchain'

# Translate the summary with OpenAI GPT
# Use LangChiain to format prompt and get result in JSON
class TranslationService
  include ApplicationHelper

  PROMPT_TEMPLATE = <<~TEMPLATE.freeze
    You are a highly skilled translator with expertise in many languages.
    Your task is to identify the language of the text I provide and accurately translate it into the {language} language while preserving the meaning, tone, and nuance of the original text. Please maintain proper grammar, spelling, and punctuation in the translated version.
      {format_instructions}
      title: {title}
      body: {body}
      action: {action}
  TEMPLATE

  def initialize(user_language, summarized_json)
    @language_name = language_name(user_language)
    @summarized_json = summarized_json
    @llm = initialize_llm
  end

  def call
    translation_schema = generate_translation_schema
    parser = Langchain::OutputParsers::StructuredOutputParser.from_json_schema(translation_schema)
    prompt_text = format_prompt(parser)

    llm_response = @llm.chat(messages: [{ role: 'user', content: prompt_text }]).completion
    parser.parse(llm_response)
  end

  private

  def initialize_llm
    llm_options = {
      temperature: 0.2,
      modelName: 'gpt-3.5-turbo',
      topP: 1,
      frequencyPenalty: 0.4,
      presencePenalty: 0.4
    }
    Langchain::LLM::OpenAI.new(api_key: ENV['openai_api_key'], llm_options:)
  end

  def generate_translation_schema
    {
      type: 'object',
      properties: {
        title: { type: 'string', description: "Translate title to #{@language_name}." },
        body: { type: 'string', description: "Translate body to #{@language_name}." },
        action: { type: 'string', description: "Translate action to #{@language_name}." }
      },
      required: %w[title body action],
      additionalProperties: false
    }
  end

  def format_prompt(parser)
    prompt = Langchain::Prompt::PromptTemplate.new(template: PROMPT_TEMPLATE,
                                                   input_variables: %w[language title body action format_instructions])
    prompt.format(
      language: @language_name,
      title: @summarized_json['title'],
      body: @summarized_json['body'],
      action: @summarized_json['action'],
      format_instructions: parser.get_format_instructions
    )
  end
end
