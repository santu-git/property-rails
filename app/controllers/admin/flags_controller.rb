class Admin::FlagsController < ApplicationController
  before_action :authenticate_user!

  def create
    @flag = Flag.new(feature_params)
    if @flag.save
      render json: {message: 'Flag saved', status: 200}, status: 200
    else
      render json: {message: 'Flag not saved', status: 400}, status: 400
    end
  end

  def destroy
    @flag = Flag.find(params[:id])
    @flag.destroy
    redirect_to edit_admin_listing_path(@flag.listing_id)
  end

  private
    def feature_params
      params.require(:flag).permit(:listing_id, :value)
    end

end
