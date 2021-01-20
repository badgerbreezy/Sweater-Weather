class Api::V1::BackgroundsController < ApplicationController
  def index
    if params[:location].empty?
      render json: payload, :status=>400
      return
    else
      background = BackgroundImageFacade.get_background_image(params[:location])
      render json: ImageSerializer.new(background)
    end
  end

  private

  def payload
    {
      error: 'Location cannot be empty',
      status: '400'
    }
  end
end
