class Admin::DepartmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    # Get departments
    @departments = Department.all.paginate(
      :page => params[:page],
      :per_page => 10
    )
    # Check with pundit if the user has permission
    authorize @departments
  end

  def json
    # Get assets
    @departments = Department.all
    # Check with pundit if the user has permission
    authorize @departments, :json?
    
    render json: @departments

  end  

  def new
    # Create new instance of department
    @department = Department.new
    # Check with pundit if able to create new
    authorize @department
  end

  def create
    # Create new instance from params
    @department = Department.new(department_params)
    # Check with pundit if the user has permission
    authorize @department
    # Survived so save department
    if @department.save
      flash[:notice] = 'Department successfully created'
      redirect_to admin_departments_path
    else
      flash[:alert] = 'Unable to create department'            
      render 'new'
    end
  end

  def edit
    # Get department
    @department = Department.find(params[:id])
    # Check with pundit if the user has permission
    authorize @department
  end

  def update
    # Get department
    @department = Department.find(params[:id])
    # Check with pundit if the user has permission
    authorize @department
    # Survived so update
    if @department.update(department_params)
      flash[:notice] = 'Department successfully updated'
      redirect_to admin_departments_path
    else
      flash[:alert] = 'Unable to update department'            
      render 'edit'
    end
  end

  def destroy
    # Get deparment
    @department = Department.find(params[:id])
    # Check with pundit if the user has permission
    authorize @department
    # Survived so destroy
    if @department.destroy
      flash[:notice] = 'Departmnt successfully removed'
    end
    redirect_to admin_departments_path
  end

  private
    def department_params
      params.require(:department).permit(:value)
    end

end
