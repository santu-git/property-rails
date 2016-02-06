class Api::V1::AvailabilitiesController < Api::V1::BaseController
  before_filter :authenticate_user!

  def index
    render json: Availability.all
  end
end
