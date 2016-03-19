class Admin::AgentsController < ApplicationController
  before_action :authenticate_user!

  def index
    # Get agents
    @agents = current_user.agents.paginate(
      :page => params[:page],
      :per_page => 10
    )
    # Check with pundit if the user has permission
    authorize @agents
  end

  def json
    # Get all current user agents
    @agents = current_user.agents.all
    # Check permissions with pundit
    authorize @agents
    # Return json
    render json: @agents
  end

  def new
    # Create new instance of agent
    @agent = Agent.new
    # Check with pundit if the user has permission
    authorize @agent
  end

  def create
    # Create new agent from params and set user_id to logged in user
    @agent = Agent.new(agent_params)
    @agent.user_id = current_user.id
    # Check with pundit if the user has permission
    authorize @agent
    # Survived so save the agent
    if @agent.save
      flash[:notice] = 'Agent successfully created'
      redirect_to admin_agents_path
    else
      render 'new'
    end
  end

  def edit
    # Get the agent by id
    @agent = Agent.find(params[:id])
    # Check with pundit if the user has permission
    authorize @agent
  end

  def update
    # Get the agent by id
    @agent = Agent.find(params[:id])
    # Check with pundit if the user has permission
    authorize @agent
    # Survived so update
    if @agent && @agent.update(agent_params)
      flash[:notice] = 'Agent successfully updated'
      redirect_to admin_agents_path
    else
      render 'edit'
    end
  end

  def destroy
    @agent = Agent.find(params[:id])
    # Check with pundit if the user has permission
    authorize @agent
    # Survived so destroy agent
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
