class Admin::AssetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @assets = Asset.joins(listing: :agent).where(
      'agents.user_id = ?', current_user.id
    ).paginate(
      :page => params[:page],
      :per_page => 10
    )
  end

  def new
    @asset = Asset.new
  end

  def create
    # Get the listing this asset is for checking that the listing belongs to the user
    @listing = Listing.joins(:agent).where(
      'agents.user_id = ? AND listings.id = ?', current_user.id, asset_params[:listing_id]
    ).first
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
    @asset = Asset.joins(listing: :agent).where(
      'agents.user_id = ? AND assets.id = ?', current_user.id, params[:id]
    ).first
  end

  def update
    @asset = Asset.joins(listing: :agent).where(
      'agents.user_id = ? AND assets.id = ?', current_user.id, params[:id]
    ).first
    if @asset && @asset.update(asset_params)
      flash[:notice] = 'Asset successfully updated'
      redirect_to admin_assets_path
    else
      render 'edit'
    end
  end

  def destroy
    @asset = Asset.joins(listing: :agent).where(
      'agents.user_id = ? AND assets.id = ?', current_user.id, params[:id]
    ).first
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
