class Admin::StylesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, except: [:index, :show]

  def index
    @styles = Style.all.paginate(
      :page => params[:page],
      :per_page => 10
    )
  end

  def create
    @style = Style.new(style_params)
    if @style.save
      flash[:notice] = 'Style successfully created'
      redirect_to admin_styles_path
    else
      render 'new'
    end
  end

  def new
    @style = Style.new
  end

  def edit
    @style = Style.find(params[:id])
  end

  def update
    @style = Style.find(params[:id])
    if @style && @style.update(style_params)
      flash[:notice] = 'Style successfully updated'
      redirect_to admin_styles_path
    else
      render 'edit'
    end
  end

  def destroy
    @style = Style.find(params[:id])
    if @style && @style.destroy
      flash[:notice] = 'Style successfully removed'
    else
      flash[:alert] = 'Unable to remove style'
    end
    redirect_to admin_styles_path
  end

  private
    def style_params
      params.require(:style).permit(:value)
    end
end
