class Api::V1::ListingsController < Api::V1::BaseController
  before_filter :authenticate_user!
  before_action :validate_params

  ActionController::Parameters.action_on_unpermitted_parameters = :raise

  def search
    # Get listings for current user
    listings = Listing.belongs_to_current_user(@current_user) 

    # Get the department (either letting or sales)
    listings = listings.where(
      'department_id = ?', params[:department]
    )

    # Geo lookup
    listings = listings.near(
      [
        params[:latitude], 
        params[:longitude]
      ], 
      params[:distance]
    )

    # Pagination
    listings = listings.paginate(
      page: params[:page],
      per_page: params[:size]
    )

    #render json: listings
    render json: listings
  end

  rescue_from(ActionController::UnpermittedParameters) do |pme|
    render json: { error: { unknown_parameters: pme.params } }, status: :bad_request
  end

  private
    def validate_params
      activity = Api::V1::Validations::Search.new(params)
      if !activity.valid?
        render json: { error: activity.errors }
      end
    end


end
