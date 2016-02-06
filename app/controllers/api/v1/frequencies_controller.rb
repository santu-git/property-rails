class Api::V1::FrequenciesController < Api::V1::BaseController
  before_filter :authenticate_user!

  def index
    render json: Frequency.all
  end
end
