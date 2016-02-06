class Api::V1::ListingsController < Api::V1::BaseController
  before_filter :authenticate_user!
  
  def show
    listings = Agent.find(params[:id]).listings
    render json: listings
  end
end
