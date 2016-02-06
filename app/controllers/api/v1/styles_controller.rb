class Api::V1::StylesController < Api::V1::BaseController
  before_filter :authenticate_user!

  def index
    render json: Style.all
  end
end
