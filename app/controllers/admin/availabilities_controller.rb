class Admin::AvailabilitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, except: [:index, :show]

  def index
    @availabilities = Availability.all.paginate(
      :page => params[:page],
      :per_page => 10
    )
  end

  def create
    @availability = Availability.new(availability_params)
    if @availability.save
      flash[:notice] = 'Availability successfully created'
      redirect_to admin_availabilities_path
    else
      render 'new'
    end
  end

  def new
    @availability = Availability.new
  end

  def edit
    @availability = Availability.find(params[:id])
  end

  def update
    @availability = Availability.find(params[:id])
    if @availability && @availability.update(availability_params)
      flash[:notice] = 'Availability successfully updated'
      redirect_to admin_availabilities_path
    else
      render 'edit'
    end
  end

  def destroy
    @availability = Availability.find(params[:id])
    if @availability && @availability.destroy
      flash[:notice] = 'Availability successfully removed'
    else
      flash[:alert] = 'Unable to remove availability'
    end
    redirect_to admin_availabilities_path
  end

  private
    def availability_params
      params.require(:availability).permit(:value)
    end

end
