class Admin::AvailabilitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    # Get availabilities
    @availabilities = Availability.all.paginate(
      :page => params[:page],
      :per_page => 10
    )
    # Check with pundit if the user has permission
    authorize @availabilities
  end

  def create
    # Create instance of availability from params
    @availability = Availability.new(availability_params)
    # Check with pundit if the user has permission
    authorize @availability
    if @availability.save
      flash[:notice] = 'Availability successfully created'
      redirect_to admin_availabilities_path
    else
      flash[:alert] = 'Unable to create availability'            
      render 'new'
    end
  end

  def new
    # Create new instance of availability
    @availability = Availability.new
    # Check with pundit if the user has permission
    authorize @availability
  end

  def edit
    # Load the availability
    @availability = Availability.find(params[:id])
    # Check with pundit if the user has permission
    authorize @availability
  end

  def update
    # Load the availability
    @availability = Availability.find(params[:id])
    # Check with pundit if the user is admin so has permission
    authorize @availability
    # Survived, so update
    if @availability.update(availability_params)
      flash[:notice] = 'Availability successfully updated'
      redirect_to admin_availabilities_path
    else
      flash[:alert] = 'Unable to update availability'      
      render 'edit'
    end
  end

  def destroy
    # Load the availability
    @availability = Availability.find(params[:id])
    # Check with pundit if the user is admin so has permission
    authorize @availability
    # Survived so destroy
    if @availability.destroy
      flash[:notice] = 'Availability successfully removed'
    end
    redirect_to admin_availabilities_path
  end

  private
    def availability_params
      params.require(:availability).permit(:value)
    end

end
