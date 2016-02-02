class Admin::GeoController < ApplicationController
  before_action :authenticate_user!

  def lookup
    Geocoder.configure(
      lookup: :google,
      api_key: ENV['GOOGLE_MAP_API_KEY'],
      timeout: 10,
      region: ENV['GOOGLE_MAP_API_REGION']
    )
    render json: Geocoder.coordinates(params[:postcode])
  end

end
