class Admin::AgentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @agents = Agent.where('user_id = ?', current_user.id).paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @agent = Agent.where('id = ? and user_id = ?', params[:id], current_user.id).first
  end

  def new
    @agent = Agent.new
  end

  def create
    @agent = Agent.new(agent_params)
    @agent.user_id = current_user.id
    if @agent.save
      flash[:notice] = 'Agent details successfully added'
      redirect_to admin_agents_path
    else
      render 'new'
    end
  end

  def edit
    @agent = Agent.where('id = ? and user_id = ?', params[:id], current_user.id).first
  end

  def update
    @agent = Agent.where('id = ? and user_id = ?', params[:id], current_user.id).first
    if @agent.update(agent_params)
      flash[:notice] = 'Agent details successfully updated'
      redirect_to admin_agents_path
    else
      render 'edit'
    end
  end

  def destroy
    @agent = Agent.where('id = ? and user_id = ?', params[:id], current_user.id).first
    @agent.destroy
    flash[:notice] = 'Agent successfully removed'
    redirect_to admin_agents_path
  end

  private
    def agent_params
      params.require(:agent).permit(:name, :status)
    end

end
