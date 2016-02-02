class Admin::TypesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, except: [:index, :show]

  def index
    @types = Type.all.paginate(
      :page => params[:page],
      :per_page => 10
    )
  end

  def create
    @type = Type.new(type_params)
    if @type.save
      flash[:notice] = 'Type successfully created'
      redirect_to admin_types_path
    else
      render 'new'
    end
  end

  def new
    @type = Type.new
  end

  def edit
    @type = Type.find(params[:id])
  end

  def update
    @type = Type.find(params[:id])
    if @type && @type.update(type_params)
      flash[:notice] = 'Type successfully updated'
      redirect_to admin_types_path
    else
      render 'edit'
    end
  end

  def destroy
    @type = Type.find(params[:id])
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
