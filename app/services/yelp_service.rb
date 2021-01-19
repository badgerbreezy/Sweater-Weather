class YelpService
  def self.get_restaurant_data(term, location)
    response = conn.get("/v3/businesses/search") do |req|
      req.params[:term] = term
      req.params[:location] = location
    end
    json = JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new(url: 'https://api.yelp.com') do |f|
      f.headers['Authorization'] = "Bearer #{ENV['YELP_API_KEY']}"
    end
  end
end
