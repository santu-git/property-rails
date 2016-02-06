class Api::V1::TypesController < Api::V1::BaseController
  before_filter :authenticate_user!

  def index
    render json: Type.all
  end
end
