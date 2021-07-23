class LinksController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def create
    @link = Link.shorten(params[:url])

    render json: {
      link: @link
    }, status: :created
  end

  def show
    @link = Link.find_by(slug: params[:slug])
    
    if @link
      redirect_to @link.url
    else
      render json: {
        message: 'Slug not found'
      }, status: :not_found
    end
  end

  private

  def render_unprocessable_entity_response(exception)
    render json: {
      message: exception.message
    }, status: :unprocessable_entity
  end
end
