class BingService
  def self.get_image_data(location)
    response = conn.get('/v7.0/images/search?') do |req|
      req.params['q'] = location
    end
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://api.bing.microsoft.com') do |f|
      f.headers['Ocp-Apim-Subscription-Key'] = ENV['BING_SEARCH_KEY']
    end
  end
end
