class Admin::MediaTypesController < ApplicationController
  before_action :authenticate_user!

  def index
    # Get media types
    @mediatypes = MediaType.all.paginate(
      :page => params[:page],
      :per_page => 10
    )
    # Check with pundit if the user has permission
    authorize @mediatypes
  end

  def new
    # Create new media type instance
    @mediatype = MediaType.new
    # Check with pundit if the user has permission
    authorize @mediatype
  end

  def create
    # Create media type with params
    @mediatype = MediaType.new(media_type_params)
    # Check with pundit if the user has permission
    authorize @mediatype
    # Survived so save
    if @mediatype.save
      flash[:notice] = 'Media type successfully created'
      redirect_to admin_media_types_path
    else
      render 'new'
    end
  end

  def edit
    # Get media type
    @mediatype = MediaType.find(params[:id])
    # Check with pundit if the user has permission
    authorize @mediatype
  end

  def update
    # Get media type
    @mediatype = MediaType.find(params[:id])
    # Check with pundit if the user has permission
    authorize @mediatype
    # Survived so update
    if @mediatype && @mediatype.update(media_type_params)
      flash[:notice] = 'Media type successfully updated'
      redirect_to admin_media_types_path
    else
      render 'edit'
    end
  end

  def destroy
    # Get media type
    @mediatype = MediaType.find(params[:id])
    # Check with pundit if the user has permission
    authorize @mediatype
    # Survived so destroy
    if @mediatype && @mediatype.destroy
      flash[:notice] = 'Media type successfully removed'
    else
      flash[:alert] = 'Unable to remove media type'
    end
    redirect_to admin_media_types_path
  end

  private
    def media_type_params
      params.require(:media_type).permit(:value)
    end
end
