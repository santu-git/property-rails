class Admin::AgentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @agents = current_user.agents.paginate(
      :page => params[:page],
      :per_page => 10
    )
  end

  def new
    @agent = Agent.new
  end

  def create
    @agent = Agent.new(agent_params)
    @agent.user_id = current_user.id
    if @agent.save
      flash[:notice] = 'Agent successfully created'
      redirect_to admin_agents_path
    else
      render 'new'
    end
  end

  def edit
    @agent = current_user.agents.find_by_id(params[:id])
  end

  def update
    @agent = current_user.agents.find_by_id(params[:id])
    if @agent && @agent.update(agent_params)
      flash[:notice] = 'Agent successfully updated'
      redirect_to admin_agents_path
    else
      render 'edit'
    end
  end

  def destroy
    @agent = current_user.agents.find_by_id(params[:id])
    if @agent && @agent.destroy
      flash[:notice] = 'Agent successfully removed'
    else
      flash[:alert] = 'Unable to remove agent'
    end
    redirect_to admin_agents_path
  end

  private
    def agent_params
      params.require(:agent).permit(:name, :status)
    end

end
