class Api::V1::ListingsController < Api::V1::BaseController
  before_filter :authenticate_user!

  def search
    listings = Listing.belongs_to_current_user(@current_user)
      .where('department_id = ?', params[:department])
      .paginate(
        :page => params[:page],
        :per_page => params[:size]
      )
    #render json: listings
    render json: listings
  end
end
