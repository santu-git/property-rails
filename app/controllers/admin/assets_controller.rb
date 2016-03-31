class Admin::AssetsController < ApplicationController
  before_action :authenticate_user!

  def index
    # Get assets
    @assets = Asset.belongs_to_current_user(current_user).paginate(
      :page => params[:page],
      :per_page => 10
    )
    # Check with pundit if the user has permission
    authorize @assets    
  end

  def new
    # Create new asset
    @asset = Asset.new
    # Check with pundit if the user has permission
    authorize @asset
  end

  def create
    # Create the asset object using asset_params
    @asset = Asset.new(asset_params)
    # Check with pundit if the user has permission
    authorize @asset
    # Survived so save the asset
    if @asset.save
      flash[:notice] = 'Asset successfully created'
      redirect_to admin_assets_path
    else
      flash[:alert] = 'Unable to create asset'
      render 'new'
    end
  end

  def edit
    # Get the asset
    @asset = Asset.find(params[:id])
    # Check with pundit if the user has permission
    authorize @asset
  end

  def update
    # Get the asset
    @asset = Asset.find(params[:id])
    # Check with pundit if the user has permission
    authorize @asset
    # Survived so update
    if @asset && @asset.update(asset_params)
      flash[:notice] = 'Asset successfully updated'
      redirect_to admin_assets_path
    else
      flash[:alert] = 'Unable to update asset'      
      render 'edit'
    end
  end

  def destroy
    # Get the asset
    @asset = Asset.find(params[:id])
    # Check with pundit if the user has permission
    authorize @asset
    # Survived so destroy
    if @asset && @asset.destroy
      flash[:notice] = 'Asset successfully removed'
    end
    redirect_to admin_assets_path
  end

  private
    def asset_params
      params.require(:asset).permit(:listing_id, :media_type_id, :upload, :status)
    end

end
