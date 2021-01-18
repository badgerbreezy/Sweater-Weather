class BackgroundImageFacade
  def self.get_background_image(location)
    Image.new(location, image_data(location))
  end

  def self.image_data(location)
    background_image = BingService.get_image_data(location)[:value][0]
  end
end
