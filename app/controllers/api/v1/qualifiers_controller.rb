class Api::V1::QualifiersController < Api::V1::BaseController
  before_filter :authenticate_user!

  def index
    render json: Qualifier.all
  end
end
