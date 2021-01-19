class RoadTripFacade
  def self.create_road_trip(trip_params)
    trip = Trip.new(trip_data(trip_params))
  end

  def self.trip_data(trip_params)
    MapquestService.get_directions_data(trip_params[:origin], trip_params[:destination])
  end
end
