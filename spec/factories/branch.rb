FactoryGirl.define do
  factory :branch do
    agent
    name 'Branch'
    address_1 'Address 1'
    town_city 'Town'
    county 'County'
    postcode 'PO5 7CO'
    country 'Country'
    latitude 100
    longitude 50
    display_address 'Address 1, Town, County'
    status 1
  end
end
