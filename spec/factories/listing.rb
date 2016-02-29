FactoryGirl.define do
  factory :listing do
    branch
    age
    availability
    style
    type
    address_1 'Address Line 1'
    town_city 'Town City'
    county 'County'
    postcode 'PO5 7CO'
    country 'United Kingdom'
    latitude 100
    longitude 50
    display_address 'Address Line 1, Town City, County'
    bedrooms 2
    bathrooms 1
    ensuites 1
    receptions 1
    kitchens 1
    summary 'Test Summary'
    description 'Test Description'
    featured false
    status 1
    factory :letting_listing do
      department{create(:department, id: 2, value: 'letting')}
      frequency
      rent 100
      rent_on_application false
      student false
    end
    factory :sale_listing do
      department{create(:department, id: 1, value: 'sale')}
      qualifier
      sale_type
      tenure
      price_on_application false
      development false
      investment false
      estimated_rental_income 0
      price 100000
    end
  end

end
