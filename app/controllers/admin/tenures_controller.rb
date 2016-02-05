class Admin::TenuresController < ApplicationController
  before_action :authenticate_user!

  def index
    # Get tenures
    @tenures = Tenure.all.paginate(
      :page => params[:page],
      :per_page => 10
    )
    # Check with pundit if the user has permission
    authorize @tenures
  end

  def new
    # Create new instance
    @tenure = Tenure.new
    # Check with pundit if the user has permission
    authorize @tenure
  end

  def create
    # Create new instance from params
    @tenure = Tenure.new(tenure_params)
    # Check with pundit if the user has permission
    authorize @tenure
    # Survived so save
    if @tenure.save
      flash[:notice] = 'Tenure successfully created'
      redirect_to admin_tenures_path
    else
      render 'new'
    end
  end

  def edit
    # Get tenure
    @tenure = Tenure.find(params[:id])
    # Check with pundit if the user has permission
    authorize @tenure
  end

  def update
    # Get tenure
    @tenure = Tenure.find(params[:id])
    # Check with pundit if the user has permission
    authorize @tenure
    # Survived so update
    if @tenure && @tenure.update(tenure_params)
      flash[:notice] = 'Tenure successfully updated'
      redirect_to admin_tenures_path
    else
      render 'edit'
    end
  end

  def destroy
    # Get tenure
    @tenure = Tenure.find(params[:id])
    # Check with pundit if the user has permission
    authorize @tenure
    # Survived so destroy
    if @tenure && @tenure.destroy
      flash[:notice] = 'Tenure successfully removed'
    else
      flash[:alert] = 'Unable to remove tenure'
    end
    redirect_to admin_tenures_path
  end

  private
    def tenure_params
      params.require(:tenure).permit(:value)
    end
end
