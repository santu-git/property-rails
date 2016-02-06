class Api::V1::UsersController < Api::V1::BaseController
  before_filter :authenticate_user!

  def show
    render json: @current_user
  end

end
