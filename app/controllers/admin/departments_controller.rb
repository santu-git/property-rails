class Admin::DepartmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, except: [:index, :show]

  def index
    @departments = Department.all.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @department = Department.find(params[:id])
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      flash[:notice] = 'Department successfully added'
      redirect_to admin_departments_path
    else
      render 'new'
    end
  end

  def new
    @department = Department.new
  end

  def edit
    @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])
    if @department.update(department_params)
      flash[:notice] = 'Department successfully updated'
      redirect_to admin_departments_path
    else
      render 'edit'
    end
  end

  def destroy
    @department = Department.find(params[:id])
    @department.destroy
    flash[:notice] = 'Departmnt successfully removed'          
    redirect_to admin_departments_path
  end

  private
    def department_params
      params.require(:department).permit(:value)
    end

end
