class Admin::ListingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @listings = Listing.belongs_to_current_user(current_user).paginate(
      :page => params[:page],
      :per_page => 10
    )
    authorize @listings
  end

  def new
    @listing = Listing.new
    authorize @listing
  end

  def create
    @listing = Listing.new(listing_params)
    authorize @listing
    if @agent && @listing.save
      flash[:notice] = 'Listing successfully created'
      redirect_to admin_listings_path
    else
      render 'new'
    end
  end

  def edit
    @listing = Listing.belongs_to_current_user(current_user).find(params[:id])
    authorize @listing
  end

  def update
    @listing = Listing.belongs_to_current_user(current_user).find(params[:id])
    authorize @listing
    if @listing && @listing.update(listing_params)
      flash[:notice] = 'Listing successfully updated'
      redirect_to admin_listings_path
    else
      render 'edit'
    end
  end

  def destroy
    @listing = Listing.belongs_to_current_user(current_user).find(params[:id])
    authorize @listing
    if @listing && @listing.destroy
      flash[:notice] = 'Listing successfully removed'
    else
      flash[:alert] = 'Unable to remove listing'
    end
    redirect_to admin_listings_path
  end

  private
    def listing_params
      params.require(:listing).permit(
        :agent_id, :branch_id, :age_id, :availability_id, :department_id,
        :frequency_id, :qualifier_id, :sale_type_id, :style_id, :tenure_id,
        :type_id, :address_1, :address_2, :address_3, :address_4, :town_city,
        :county, :postcode, :country, :latitude, :longitude, :display_address,
        :bedrooms, :bathrooms, :ensuites, :receptions, :kitchens, :summary,
        :description, :price, :price_on_application, :development, :investment,
        :estimated_rental_income, :rent, :rent_on_application, :student, :featured,
        :status, features_attributes: [:id, :value, :_destroy],
        flags_attributes: [:id, :value, :_destroy]
      )
    end

end
