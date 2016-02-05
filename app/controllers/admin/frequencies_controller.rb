class Admin::FrequenciesController < ApplicationController
  before_action :authenticate_user!

  def index
    # Get frequencies
    @frequencies = Frequency.all.paginate(
      :page => params[:page],
      :per_page => 10
    )
    # Check with pundit if the user has permission
    authorize @frequencies
  end

  def new
    # Create new instance
    @frequency = Frequency.new
    # Check with pundit if the user has permission
    authorize @frequency
  end

  def create
    # Create instance from params
    @frequency = Frequency.new(frequency_params)
    # Check with pundit if the user has permission
    authorize @frequency
    # Survived so save
    if @frequency.save
      flash[:notice] = 'Frequency successfully created'
      redirect_to admin_frequencies_path
    else
      render 'new'
    end
  end

  def edit
    # Get frequency
    @frequency = Frequency.find(params[:id])
    # Check with pundit if the user has permission
    authorize @frequency
  end

  def update
    # Get frequency
    @frequency = Frequency.find(params[:id])
    # Check with pundit if the user has permission
    authorize @frequency
    if @frequency && @frequency.update(frequency_params)
      flash[:notice] = 'Frequency successfully updated'
      redirect_to admin_frequencies_path
    else
      render 'edit'
    end
  end

  def destroy
    # get frequency
    @frequency = Frequency.find(params[:id])
    # Check with pundit if the user has permission
    authorize @frequency
    # Survived so destroy
    if @frequency && @frequency.destroy
      flash[:notice] = 'Frequency successfully removed'
    else
      flash[:alert] = 'Unable to remove frequency'
    end
    redirect_to admin_frequencies_path
  end

  private
    def frequency_params
      params.require(:frequency).permit(:value)
    end
end
