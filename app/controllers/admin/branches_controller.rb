class Admin::BranchesController < ApplicationController
  before_action :authenticate_user!

  def index
    # Get branches
    @branches = Branch.belongs_to_current_user(current_user).paginate(
      :page => params[:page],
      :per_page => 10
    )
    # Check with pundit if the user has permission
    authorize @branches
  end

  def json
    # Get branches
    @branches = Branch.belongs_to_current_user(current_user).belongs_to_agent(params[:id])
    # Check with pundit if user has permission
    authorize @branches, :json?
    # Render to json
    render json: @branches
  end

  def new
    # Create new instance of branch
    @branch = Branch.new
    # Check with pundit if the user has permission
    authorize @branch
  end

  def create
    # Create instance of branch from params
    @branch = Branch.new(branch_params)
    # Check with pundit if the user has permission
    authorize @branch
    # Survived so save branch
    if @branch.save
      flash[:notice] = 'Branch successfully created'
      redirect_to admin_branches_path
    else
      flash[:alert] = 'Unable to create branch'      
      render 'new'
    end
  end

  def edit
    # Get branch
    @branch = Branch.find(params[:id])
    # Check with pundit if authorized
    authorize @branch
  end

  def update
    # Get the branch
    @branch = Branch.find(params[:id])
    # Check with pundit if the user has permission
    authorize @branch
    # Survived so update branch
    if @branch.update(branch_params)
      flash[:notice] = 'Branch successfully updated'
      redirect_to admin_branches_path
    else
      flash[:alert] = 'Unable to update branch'            
      render 'edit'
    end
  end

  def destroy
    # Get the branch
    @branch = Branch.find(params[:id])
    # Check with pundit if the user has permission
    authorize @branch
    # Survived so destroy branch
    if @branch.destroy
      flash[:notice] = 'Branch successfully removed'
    end
    redirect_to admin_branches_path
  end

  private
    def branch_params
      params.require(:branch).permit(
        :agent_id, :name, :address_1, :address_2, :address_3, :address_4,
        :town_city, :county, :postcode, :country, :latitude, :longitude,
        :display_address, :status
      )
    end

end
