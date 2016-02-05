class Admin::StylesController < ApplicationController
  before_action :authenticate_user!

  def index
    # Get styles
    @styles = Style.all.paginate(
      :page => params[:page],
      :per_page => 10
    )
    # Check with pundit if the user has permission
    authorize @styles
  end

  def new
    # New instance
    @style = Style.new
    # Check with pundit if the user has permission
    authorize @style
  end

  def create
    # Create new instance from params
    @style = Style.new(style_params)
    # Check with pundit if the user has permission
    authorize @style
    # Survived so saved
    if @style.save
      flash[:notice] = 'Style successfully created'
      redirect_to admin_styles_path
    else
      render 'new'
    end
  end

  def edit
    # Get style
    @style = Style.find(params[:id])
    # Check with pundit if the user has permission
    authorize @style
  end

  def update
    # Get style
    @style = Style.find(params[:id])
    # Check with pundit if the user has permission
    authorize @style
    # Survived so update
    if @style && @style.update(style_params)
      flash[:notice] = 'Style successfully updated'
      redirect_to admin_styles_path
    else
      render 'edit'
    end
  end

  def destroy
    @style = Style.find(params[:id])
    # Check with pundit if the user has permission
    authorize @style
    # Survived so destroy
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
