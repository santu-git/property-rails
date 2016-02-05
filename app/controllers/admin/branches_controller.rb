class Admin::BranchesController < ApplicationController
  before_action :authenticate_user!

  def index
    @branches = Branch.belongs_to_current_user(current_user).paginate(
      :page => params[:page],
      :per_page => 10
    )
  end

  def new
    @branch = Branch.new
  end

  def create
    @agent = Agent.belongs_to_current_user(current_user).find(branch_params[:agent_id])
    @branch = Branch.new(branch_params)
    if @agent && @branch.save
      flash[:notice] = 'Branch successfully created'
      redirect_to admin_branches_path
    else
      render 'new'
    end
  end

  def json
    @branches = Branch.belongs_to_current_user(current_user).belongs_to_agent(params[:id])
    render json: @branches
  end

  def edit
    @branch = Branch.belongs_to_current_user(current_user).find(params[:id])
  end

  def update
    @branch = Branch.belongs_to_current_user(current_user).belongs_to_agent(params[:id])
    if @branch && @branch.update(branch_params)
      flash[:notice] = 'Branch successfully updated'
      redirect_to admin_branches_path
    else
      render 'edit'
    end
  end

  def destroy
    @branch = Branch.belongs_to_current_user(current_user).belongs_to_agent(params[:id])
    if @branch && @branch.destroy
      flash[:notice] = 'Branch successfully removed'
    else
      flash[:alert] = 'Unable to remove branch'
    end
    redirect_to admin_branches_path
  end

  private
    def branch_params
      params.require(:branch).permit(
        :agent_id, :name, :address_1, :address_2, :address_3, :address_4, :town_city, :county, :postcode, :country,
        :latitude, :longitude, :display_address, :status
      )
    end

end
