require 'langchain'

# Summary the extracted text with OpenAI GPT
# Using LangChain to format prompt and get result in JSON
class SummaryService
  PROMPT_TEMPLATE = "For the following text, extract the following information.\ntext: {text}\n{format_instructions}".freeze
  SUMMARY_SCHEMA = {
    type: 'object',
    properties: {
      title: {
        type: 'string',
        description: "A short title that is concise, descriptive, and directly reflective of the summary's main content."
      },
      body: {
        type: 'string',
        description: 'Summarize the letter, focusing on the main purpose, any offers or requests made. Keep the summary concise, within two sentences.'
      },
      action: {
        type: 'string',
        description: 'Any actions that the recipient needs to take in one sentance.'
      }
    },
    required: %w[title body action],
    additionalProperties: false
  }.freeze

  def initialize(extracted_text)
    @extracted_text = extracted_text
    @llm = initialize_llm
  end

  def call
    parser = Langchain::OutputParsers::StructuredOutputParser.from_json_schema(SUMMARY_SCHEMA)
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

  def format_prompt(parser)
    prompt = Langchain::Prompt::PromptTemplate.new(template: PROMPT_TEMPLATE,
                                                   input_variables: %w[text format_instructions])
    prompt.format(text: @extracted_text, format_instructions: parser.get_format_instructions)
  end
end
