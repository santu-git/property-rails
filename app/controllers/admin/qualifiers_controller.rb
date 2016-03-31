class Admin::QualifiersController < ApplicationController
  before_action :authenticate_user!

  def index
    # Get qualifiers
    @qualifiers = Qualifier.all.paginate(
      :page => params[:page],
      :per_page => 10
    )
    # Check with pundit if the user has permission
    authorize @qualifiers
  end

  def new
    # Create new qualifier instance
    @qualifier = Qualifier.new
    # Check with pundit if the user has permission
    authorize @qualifier
  end

  def create
    # Create qualifer from params
    @qualifier = Qualifier.new(qualifier_params)
    # Check with pundit if the user has permission
    authorize @qualifier
    # Survived so save
    if @qualifier.save
      flash[:notice] = 'Qualifier successfully created'
      redirect_to admin_qualifiers_path
    else
      flash[:alert] = 'Unable to create qualifier'            
      render 'new'
    end
  end

  def edit
    # Get qualifier
    @qualifier = Qualifier.find(params[:id])
    # Check with pundit if the user has permission
    authorize @qualifier
  end

  def update
    # Get qualifier
    @qualifier = Qualifier.find(params[:id])
    # Check with pundit if the user has permission
    authorize @qualifier
    # Survived so update
    if @qualifier.update(qualifier_params)
      flash[:notice] = 'Qualifier successfully updated'
      redirect_to admin_qualifiers_path
    else
      flash[:alert] = 'Unable to update qualifier'            
      render 'edit'
    end
  end

  def destroy
    @qualifier = Qualifier.find(params[:id])
    # Check with pundit if the user has permission
    authorize @qualifier
    # Survived so destroy
    if @qualifier.destroy
      flash[:notice] = 'Qualifier successfully removed'
    end
    redirect_to admin_qualifiers_path
  end

  private
    def qualifier_params
      params.require(:qualifier).permit(:value)
    end
end
