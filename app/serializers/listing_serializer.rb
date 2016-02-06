class ListingSerializer < ActiveModel::Serializer
  attributes :id, :address_1, :address_2, :address_3, :address_4,
  :town_city, :county, :postcode, :country, :latitude, :longitude, :display_address,
  :bedrooms, :bathrooms, :ensuites, :receptions, :kitchens, :summary, :description,
  :price
  belongs_to :branch
end
