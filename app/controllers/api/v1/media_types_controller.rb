class Api::V1::MediaTypesController < Api::V1::BaseController
  before_filter :authenticate_user!

  def index
    render json: MediaType.all
  end
end
