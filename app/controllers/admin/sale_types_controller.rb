class Admin::SaleTypesController < ApplicationController
  before_action :authenticate_user!

  def index
    # Get sale types
    @saletypes = SaleType.all.paginate(
      :page => params[:page],
      :per_page => 10
    )
    # Check with pundit if the user has permission
    authorize @saletypes
  end

  def new
    # Create new instance of sale type
    @saletype = SaleType.new
    # Check with pundit if the user has permission
    authorize @saletype
  end

  def create
    # Create new instance of sale type from params
    @saletype = SaleType.new(sale_type_params)
    # Check with pundit if the user has permission
    authorize @saletype
    # Survived so save
    if @saletype.save
      flash[:notice] = 'Sale type successfully created'
      redirect_to admin_sale_types_path
    else
      flash[:alert] = 'Unable to create sale type'            
      render 'new'
    end
  end

  def edit
    # Get sale type
    @saletype = SaleType.find(params[:id])
    # Check with pundit if the user has permission
    authorize @saletype
  end

  def update
    # Get sale type
    @saletype = SaleType.find(params[:id])
    # Check with pundit if the user has permission
    authorize @saletype
    # Survived so update
    if @saletype.update(sale_type_params)
      flash[:notice] = 'Sale type successfully updated'
      redirect_to admin_sale_types_path
    else
      flash[:alert] = 'Unable to update sale type'            
      render 'edit'
    end
  end

  def destroy
    @saletype = SaleType.find(params[:id])
    # Check with pundit if the user has permission
    authorize @saletype
    # Survived so destroy
    if @saletype.destroy
      flash[:notice] = 'Sale type successfully removed'
    end
    redirect_to admin_sale_types_path
  end

  private
    def sale_type_params
      params.require(:sale_type).permit(:value)
    end
end
