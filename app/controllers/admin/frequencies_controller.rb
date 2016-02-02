class Admin::FrequenciesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, except: [:index, :show]

  def index
    @frequencies = Frequency.all.paginate(
      :page => params[:page],
      :per_page => 10
    )
  end

  def create
    @frequency = Frequency.new(frequency_params)
    if @frequency.save
      flash[:notice] = 'Frequency successfully created'
      redirect_to admin_frequencies_path
    else
      render 'new'
    end
  end

  def new
    @frequency = Frequency.new
  end

  def edit
    @frequency = Frequency.find(params[:id])
  end

  def update
    @frequency = Frequency.find(params[:id])
    if @frequency && @frequency.update(frequency_params)
      flash[:notice] = 'Frequency successfully updated'
      redirect_to admin_frequencies_path
    else
      render 'edit'
    end
  end

  def destroy
    @frequency = Frequency.find(params[:id])
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
