class Admin::AssetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @assets = Asset.belongs_to_current_user(current_user).paginate(
      :page => params[:page],
      :per_page => 10
    )
  end

  def new
    @asset = Asset.new
  end

  def create
    # Get the listing this asset is for checking that the listing belongs to the user
    @listing = Listing.belongs_to_current_user(current_user).find(asset_params[:listing_id])
    # Create the asset object using asset_params
    @asset = Asset.new(asset_params)
    # Check is the listing was found and the asset saved
    if @listing && @asset.save
      flash[:notice] = 'Asset successfully created'
      redirect_to admin_assets_path
    else
      render 'new'
    end
  end

  def edit
    @asset = Asset.belongs_to_current_user(current_user).find(params[:id])
  end

  def update
    @asset = Asset.belongs_to_current_user(current_user).find(params[:id])
    if @asset && @asset.update(asset_params)
      flash[:notice] = 'Asset successfully updated'
      redirect_to admin_assets_path
    else
      render 'edit'
    end
  end

  def destroy
    @asset = Asset.belongs_to_current_user(current_user).find(params[:id])
    if @asset && @asset.destroy
      flash[:notice] = 'Asset successfully removed'
    else
      flash[:alert] = 'Unable to remove asset'
    end
    redirect_to admin_assets_path
  end

  private
    def asset_params
      params.require(:asset).permit(:listing_id, :media_type_id, :upload, :status)
    end

end
