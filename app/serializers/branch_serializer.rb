class BranchSerializer < ActiveModel::Serializer
  attributes :id, :name, :address_1, :address_2, :address_3, :address_4,
  :town_city, :county, :postcode, :country, :latitude, :longitude, :display_address
end
