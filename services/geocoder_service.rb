class GeocoderService
  attr_reader :location, :location_name, :results, :country, :city

  def initialize(location)
    @location = location
    @location_name = location.name
    @results = Geocoder.search(location_name)
    if results.first
      @country = results.first.country
      puts results.first
      @city = results.first.formatted_address if results.first
    end
  end

  def geocode_location
    found_city = City.find_or_create_by_name(city)
    found_country = Country.find_or_create_by_name(country)
    location.city = found_city
    found_city.country = found_country
    found_city.save!
  end

end