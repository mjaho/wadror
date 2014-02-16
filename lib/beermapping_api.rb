class BeermappingApi
  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, :expires_in => 7.days) { fetch_places_in(city) }
    #Rails.cache.fetch(city, :expires_in => 30.seconds) { fetch_places_in(city) }
    #Rails.cache.fetch(city) { fetch_places_in(city) }
  end

  private

  def self.fetch_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
  end

  def self.key
    #Ilmeisesti herokussa ei toimi settingsin kautta. Vaihtoehtoina käyttää
    #Settings.beermapping_apikey
    "b65607149f4bcfd5bcc268f9ebc6942e"
  end
end