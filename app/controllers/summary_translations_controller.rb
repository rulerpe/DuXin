class SummaryTranslationsController < ApplicationController
  before_action :set_summary_translation, only: %i[show update destroy]
  before_action :authenticate_request

  # GET /summary_translations
  def index
    @summary_translations = @current_user.summary_translations.order(created_at: :desc).page(params[:page]).per(10)

    render json: @summary_translations
  end

  # GET /summary_translations/1
  def show
    render json: @summary_translation
  end

  # POST /summary_translations
  def create
    @summary_translation = @current_user.summary_translations.build(summary_translation_params)

    if @summary_translation.save
      render json: @summary_translation, status: :created, location: @summary_translation
    else
      render json: @summary_translation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /summary_translations/1
  def update
    if @summary_translation.update(summary_translation_params)
      render json: @summary_translation
    else
      render json: @summary_translation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /summary_translations/1
  def destroy
    @summary_translation.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_summary_translation
    @summary_translation = SummaryTranslation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def summary_translation_params
    params.require(:summary_translation).permit(:image_record_id, :original_title, :translated_title, :original_body,
                                                :translated_body, :original_action, :translated_action, :original_language, :translation_language)
  end
end
