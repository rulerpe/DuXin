class ImagesController < ApplicationController
    before_action :authenticate_request

    def upload
        if params[:image].present?
            image_path = params[:image].tempfile.path
            TextractJob.perform_later(@current_user.id, image_path)
            render json: { message: "Image uploaded and processed successfully." }, status: :ok
        else
            render json: { error: "No image file provided." }, status: :unprocessable_entity
        end
    end
end
