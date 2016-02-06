class Admin::AgesController < ApplicationController
  before_action :authenticate_user!

  def index
    # Get ages
    @ages = Age.all.paginate(
      :page => params[:page],
      :per_page => 10
    )
    # Check with pundit if the user has permission
    authorize @ages
  end

  def new
    # Create new instance of age
    @age = Age.new
    # Check with pundit if able to create new
    authorize @age
  end

  def create
    # Create instance of age from params
    @age = Age.new(age_params)
    # Check with pundit if the user has permission
    authorize @age
    # Save the new age
    if @age.save
      flash[:notice] = 'Age successfully created'
      redirect_to admin_ages_path
    else
      render 'new'
    end
  end

  def edit
    # Load the age
    @age = Age.find(params[:id])
    # Check with pundit if can edit
    authorize @age
  end

  def update
    # Get the age to update
    @age = Age.find(params[:id])
    # Check with pundit if the user is admin so has permission
    authorize @age
    # Survived, so update
    if @age.update(age_params)
      flash[:notice] = 'Age successfully updated'
      redirect_to admin_ages_path
    else
      render 'edit'
    end
  end

  def destroy
    # Get the age to destroy
    @age = Age.find(params[:id])
    # Check with pundit if can be destroyed
    authorize @age
    # Survived so destroy
    if @age && @age.destroy
      flash[:notice] = 'Agent successfully removed'
    else
      flash[:alert] = 'Unable to remove age'
    end
    redirect_to admin_ages_path
  end

  private
    def age_params
      params.require(:age).permit(:value)
    end

end
