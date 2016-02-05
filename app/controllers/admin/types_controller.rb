class Admin::TypesController < ApplicationController
  before_action :authenticate_user!

  def index
    # Get types
    @types = Type.all.paginate(
      :page => params[:page],
      :per_page => 10
    )
    # Check with pundit if the user has permission
    authorize @types
  end

  def new
    # Create instance
    @type = Type.new
    # Check with pundit if the user has permission
    authorize @type
  end

  def create
    # Create instance from params
    @type = Type.new(type_params)
    # Check with pundit if the user has permission
    authorize @type
    # Survived so save
    if @type.save
      flash[:notice] = 'Type successfully created'
      redirect_to admin_types_path
    else
      render 'new'
    end
  end

  def edit
    # Get type
    @type = Type.find(params[:id])
    # Check with pundit if the user has permission
    authorize @type
  end

  def update
    # Get type
    @type = Type.find(params[:id])
    # Check with pundit if the user has permission
    authorize @type
    # Survived so update
    if @type && @type.update(type_params)
      flash[:notice] = 'Type successfully updated'
      redirect_to admin_types_path
    else
      render 'edit'
    end
  end

  def destroy
    @type = Type.find(params[:id])
    # Check with pundit if the user has permission
    authorize @type
    # Survived so destroy
    if @type && @type.destroy
      flash[:notice] = 'Type successfully removed'
    else
      flash[:alert] = 'Unable to remove type'
    end
    redirect_to admin_types_path
  end

  private
    def type_params
      params.require(:type).permit(:value)
    end
end
