class Api::V1::AgentsController < Api::V1::BaseController
  before_filter :authenticate_user!

  def show
    agents = User.find(params[:id]).agents
    render json: agents
  end
end
