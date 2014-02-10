class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  def show
    loc_id = "#{params[:id]}"
    key = Settings.beermapping_apikey
    url = "http://beermapping.com/webservice/locquery/#{key}/"+loc_id

    response = HTTParty.get "#{url}"

    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end

    @place = Place.new places.first
  end
end