class Api::V1::TenuresController < Api::V1::BaseController
  before_filter :authenticate_user!

  def index
    render json: Tenure.all
  end
end
