class Api::V1::DepartmentsController < Api::V1::BaseController
  before_filter :authenticate_user!

  def index
    render json: Department.all
  end
end
