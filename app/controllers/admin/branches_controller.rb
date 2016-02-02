class Admin::BranchesController < ApplicationController
  before_action :authenticate_user!

  def index
    @branches = Branch.joins(:agent).where('agents.user_id = ?', current_user.id).paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @branch = Branch.joins(:agent).where('branches.id = ?', params[:id]).where('agents.user_id = ?', current_user.id).first
  end

  def new
    @branch = Branch.new
  end

  def create
    @branch = Branch.new(branch_params)
    if @branch.save
      flash[:notice] = 'Branch successfully added'
      redirect_to admin_branches_path
    else
      render 'new'
    end
  end

  def json
    @branches = Branch.joins(:agent).where('branches.agent_id = ?', params[:id]).where('agents.user_id = ?', current_user.id)
    render json: @branches
  end

  def edit
    @branch = Branch.joins(:agent).where('branches.id = ?', params[:id]).where('agents.user_id = ?', current_user.id).first
  end

  def update
    @branch = Branch.joins(:agent).where('branches.id = ?', params[:id]).where('agents.user_id = ?', current_user.id).first
    if @branch.update(branch_params)
      flash[:notice] = 'Branch successfully updated'
      redirect_to admin_branches_path
    else
      render 'edit'
    end
  end

  def destroy
    @branch = Branch.joins(:agent).where('branches.id = ?', params[:id]).where('agents.user_id = ?', current_user.id).first
    @branch.destroy
    flash[:notice] = 'Branch successfully removed'
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
