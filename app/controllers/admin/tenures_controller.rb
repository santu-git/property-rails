class Admin::TenuresController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, except: [:index, :show]

  def index
    @tenures = Tenure.all.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @tenure = Tenure.find(params[:id])
  end

  def create
    @tenure = Tenure.new(tenure_params)
    if @tenure.save
      flash[:notice] = 'Tenure successfully added'
      redirect_to admin_tenures_path
    else
      render 'new'
    end
  end

  def new
    @tenure = Tenure.new
  end

  def edit
    @tenure = Tenure.find(params[:id])
  end

  def update
    @tenure = Tenure.find(params[:id])
    if @tenure.update(tenure_params)
      flash[:notice] = 'Tenure successfully updated'
      redirect_to admin_tenures_path
    else
      render 'edit'
    end
  end

  def destroy
    @tenure = Tenure.find(params[:id])
    @tenure.destroy
    flash[:notice] = 'Tenure successfully removed'          
    redirect_to admin_tenures_path
  end

  private
    def tenure_params
      params.require(:tenure).permit(:value)
    end
end
