class Admin::AgesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, except: [:index, :show]

  def index
    @ages = Age.all.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @age = Age.find(params[:id])
  end

  def create
    @age = Age.new(age_params)
    if @age.save
      flash[:notice] = 'Age successfully added'
      redirect_to admin_ages_path
    else
      render 'new'
    end
  end

  def new
    @age = Age.new
  end

  def edit
    @age = Age.find(params[:id])
  end

  def update
    @age = Age.find(params[:id])
    if @age.update(age_params)
      flash[:notice] = 'Age successfully updated'
      redirect_to admin_ages_path
    else
      render 'edit'
    end
  end

  def destroy
    @age = Age.find(params[:id])
    @age.destroy
    flash[:notice] = 'Agent successfully removed'
    redirect_to admin_ages_path
  end

  private
    def age_params
      params.require(:age).permit(:value)
    end

end
