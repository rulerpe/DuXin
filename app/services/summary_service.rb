require 'langchain'

# Summary the extracted text with OpenAI GPT
# Using LangChain to format and get result in JSON
class SummaryService
  def initialize(extracted_text)
    @extracted_text = extracted_text
    llm_options = {
      temperature: 0.2,
      modelName: 'gpt-3.5-turbo',
      topP: 1,
      frequencyPenalty: 0.4,
      presencePenalty: 0.4
    }
    @llm = Langchain::LLM::OpenAI.new(api_key: ENV['openai_api_key'], llm_options:)
  end

  def call
    prompt_template = "For the following text, extract the following information:
    title: A short title that is concise, descriptive, and directly reflective of the summary's main content.
    body: Summarize the letter, focusing on the main purpose, any offers or requests made. Keep the summary concise, within two sentences.
    action: Any actions that the recipient needs to take in one sentance.

    text: {text}

    {format_instructions}
    "

    json_schema = {
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
    }
    parser = Langchain::OutputParsers::StructuredOutputParser.from_json_schema(json_schema)
    prompt = Langchain::Prompt::PromptTemplate.new(template: prompt_template,
                                                   input_variables: %w[
                                                     text format_instructions
                                                   ])
    prompt_text = prompt.format(text: @extracted_text,
                                format_instructions: parser.get_format_instructions)
    llm_response = @llm.chat(messages: [{ role: 'user',
                                          content: prompt_text }]).completion
    parser.parse(llm_response)
  end
end
