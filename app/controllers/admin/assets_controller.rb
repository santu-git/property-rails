class Admin::AssetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @assets = Asset.joins(
      'inner join listings on assets.listing_id = listings.id inner join agents on listings.agent_id = agents.id'
    ).where('agents.user_id = ?', current_user.id).paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @asset = Asset.new
  end

  def create
    @asset = Asset.new(asset_params)
    if @asset.save
      flash[:notice] = 'Asset successfully added'
      redirect_to admin_assets_path
    else
      render 'new'
    end
  end

  def edit
    @asset = Asset.find(params[:id])
  end

  def update
    @asset = Asset.find(params[:id])
    if @asset.update(asset_params)
      redirect_to admin_assets_path
    else
      render 'edit'
    end
  end

  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy
    redirect_to admin_assets_path
  end

  private
    def asset_params
      params.require(:asset).permit(:listing_id, :media_type_id, :upload, :status)
    end

end
