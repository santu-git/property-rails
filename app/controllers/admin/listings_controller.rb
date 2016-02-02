class Admin::ListingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @listings = Listing.joins(:agent).where('agents.id = listings.agent_id').where('agents.user_id = ?', current_user.id).paginate(:page => params[:page], :per_page => 5)
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    if @listing.save
      flash[:notice] = 'Listing successfully added'
      redirect_to edit_admin_listing_path(@listing)
    else
      render 'new'
    end
  end

  def edit
    @listing = Listing.joins(:agent).where('agents.id = listings.agent_id').where('agents.user_id = ?', current_user.id).where('listings.id = ?', params[:id]).first
    @features = Feature.where('features.listing_id = ?', @listing.id)
    @flags = Flag.where('flags.listing_id = ?', @listing.id)
  end

  def update
    @listing = Listing.joins(:agent).where('agents.id = listings.agent_id').where('agents.user_id = ?', current_user.id).where('listings.id = ?', params[:id]).first
    if @listing.update(listing_params)
      flash[:notice] = 'Listing successfully updated'
      redirect_to admin_listings_path
    else
      render 'edit'
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    flash[:notice] = 'Listing successfully removed'      
    redirect_to admin_listings_path
  end

  private
    def listing_params
      params.require(:listing).permit(
        :agent_id, :branch_id, :age_id, :availability_id, :department_id, :frequency_id,
        :qualifier_id, :sale_type_id, :style_id, :tenure_id, :type_id, :address_1, :address_2,
        :address_3, :address_4, :town_city, :county, :postcode, :country, :latitude, :longitude,
        :display_address, :bedrooms, :bathrooms, :ensuites, :receptions, :kitchens, :summary,
        :description, :price, :price_on_application, :development, :investment, :estimated_rental_income,
        :rent, :rent_on_application, :student, :featured, :status
      )
    end

end
