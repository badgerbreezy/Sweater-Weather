class MunchiesFacade
  def self.create_trip_with_food(trip_params)
    Munchies.new(food_data(trip_params), trip_data(trip_params))
  end

  def self.trip_data(trip_params)
    MapquestService.get_directions_data(trip_params[:start], trip_params[:end_location])
  end

  def self.food_data(trip_params)
    YelpService.get_restaurant_data(trip_params[:food], trip_params[:end_location])
  end
end
