class Api::V1::MunchiesController < ApplicationController
  def index
    munchies_facade = MunchiesFacade.create_trip_with_food(munchies_params)
    render json: MunchiesSerializer.new(munchies_facade)
  end

  private

  def munchies_params
    params.permit(:start, :end_location, :food)
  end
end
