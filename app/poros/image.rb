class Image
  attr_reader :id,
              :image

  def initialize(location, data)
    @id = nil
    @image = {
      location:  location,
      image_url: data[:contentUrl],
      credit: {
        source: data[:hostPageDomainFriendlyName]
      }
    }
  end
end
