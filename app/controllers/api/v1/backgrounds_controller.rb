class Api::V1::BackgroundsController < ApplicationController
  def index
    background = BackgroundImageFacade.get_background_image(location_params[:location])
    render json: ImageSerializer.new(background)
  end

  private

  def location_params
    params.permit(:location)
  end
end
