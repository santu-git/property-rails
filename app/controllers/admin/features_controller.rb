class Admin::FeaturesController < ApplicationController
  before_action :authenticate_user!

  def create
    @feature = Feature.new(feature_params)
    if @feature.save
      render json: {message: 'Feature saved', status: 200}, status: 200
    else
      render json: {message: 'Featured not saved', status: 400}, status: 400
    end
  end

  def destroy
    @feature = Feature.find(params[:id])
    @feature.destroy
    redirect_to edit_admin_listing_path(@feature.listing_id)
  end

  private
    def feature_params
      params.require(:feature).permit(:listing_id, :value)
    end
end
