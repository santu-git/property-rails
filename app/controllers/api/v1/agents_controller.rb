class Api::V1::AgentsController < Api::V1::BaseController
  before_filter :authenticate_user!

  def index
    agents = @current_user.agents
    render json: agents
  end
end
