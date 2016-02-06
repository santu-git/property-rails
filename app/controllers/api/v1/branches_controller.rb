class Api::V1::BranchesController < Api::V1::BaseController
  before_filter :authenticate_user!

  def show
    render json: @current_user.agents.find(params[:id]).branches
  end

end
