class Admin::QualifiersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, except: [:index, :show]

  def index
    @qualifiers = Qualifier.all.paginate(
      :page => params[:page],
      :per_page => 10
    )
  end

  def create
    @qualifier = Qualifier.new(qualifier_params)
    if @qualifier.save
      flash[:notice] = 'Qualifier successfully created'
      redirect_to admin_qualifiers_path
    else
      render 'new'
    end
  end

  def new
    @qualifier = Qualifier.new
  end

  def edit
    @qualifier = Qualifier.find(params[:id])
  end

  def update
    @qualifier = Qualifier.find(params[:id])
    if @qualifier && @qualifier.update(qualifier_params)
      flash[:notice] = 'Qualifier successfully updated'
      redirect_to admin_qualifiers_path
    else
      render 'edit'
    end
  end

  def destroy
    @qualifier = Qualifier.find(params[:id])
    if @qualifier && @qualifier.destroy
      flash[:notice] = 'Qualifier successfully removed'
    else
      flash[:alert] = 'Unable to remove qualifier'
    end
    redirect_to admin_qualifiers_path
  end

  private
    def qualifier_params
      params.require(:qualifier).permit(:value)
    end
end
