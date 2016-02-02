class Admin::SaleTypesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, except: [:index, :show]

  def index
    @saletypes = SaleType.all.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @saletype = SaleType.find(params[:id])
  end

  def create
    @saletype = SaleType.new(sale_type_params)
    if @saletype.save
      flash[:notice] = 'Sale type successfully added'
      redirect_to admin_sale_types_path
    else
      render 'new'
    end
  end

  def new
    @saletype = SaleType.new
  end

  def edit
    @saletype = SaleType.find(params[:id])
  end

  def update
    @saletype = SaleType.find(params[:id])
    if @saletype.update(sale_type_params)
      flash[:notice] = 'Sale type successfully updated'
      redirect_to admin_sale_types_path
    else
      render 'edit'
    end
  end

  def destroy
    @style = SaleType.find(params[:id])
    @style.destroy
    flash[:notice] = 'Sale type successfully removed'          
    redirect_to admin_sale_types_path
  end

  private
    def sale_type_params
      params.require(:sale_type).permit(:value)
    end
end
