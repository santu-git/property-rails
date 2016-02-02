class Admin::MediaTypesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, except: [:index, :show]

  def index
    @mediatypes = MediaType.all.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @mediatype = MediaType.find(params[:id])
  end

  def create
    @mediatype = MediaType.new(media_type_params)
    if @mediatype.save
      flash[:notice] = 'Media type successfully added'
      redirect_to admin_media_types_path
    else
      render 'new'
    end
  end

  def new
    @mediatype = MediaType.new
  end

  def edit
    @mediatype = MediaType.find(params[:id])
  end

  def update
    @mediatype = MediaType.find(params[:id])
    if @mediatype.update(media_type_params)
      flash[:notice] = 'Media type successfully updated'
      redirect_to admin_media_types_path
    else
      render 'edit'
    end
  end

  def destroy
    @mediatype = MediaType.find(params[:id])
    @mediatype.destroy
    flash[:notice] = 'Media type successfully removed'          
    redirect_to admin_media_types_path
  end

  private
    def media_type_params
      params.require(:media_type).permit(:value)
    end
end
