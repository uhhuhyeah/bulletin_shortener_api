class LinksController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def create
    @link = Link.shorten(params[:url])

    render json: {
      link: @link
    }, status: :created
  end

  private

  def render_unprocessable_entity_response(exception)
    render json: {
      message: exception.message
    }, status: :unprocessable_entity
  end
end
