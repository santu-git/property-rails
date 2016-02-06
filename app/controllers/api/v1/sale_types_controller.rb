class Api::V1::SaleTypesController < Api::V1::BaseController
  before_filter :authenticate_user!

  def index
    render json: SaleType.all
  end
end
