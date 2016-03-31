# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
Age.delete_all
Age.create([
  {id: 1, value: 'Not Specified'},
  {id: 2, value: 'New Build'},
  {id: 3, value: 'Modern'},
  {id: 4, value: '1980s to 1990s'},
  {id: 5, value: '1950s, 1960s and 1970s'},
  {id: 6, value: '1940s'},
  {id: 7, value: '1920s to 1930s'},
  {id: 8, value: 'Edwardian (1901 - 1910)'},
  {id: 9, value: 'Victorian (1837 - 1901)'},
  {id: 10, value: 'Georgian (1714 - 1830)'},
  {id: 11, value: 'Pre 18th Century'}
])
Availability.delete_all
Availability.create([
  {id: 1, value: 'On Hold'},
  {id: 2, value: 'For Sale'},
  {id: 3, value: 'Under Offer'},
  {id: 4, value: 'Sold STC'},
  {id: 5, value: 'Sold'},
  {id: 6, value: 'Withdrawn'},
  {id: 7, value: 'To Let'},
  {id: 8, value: 'References Pending'},
  {id: 9, value: 'Let Agreed'},
  {id: 10, value: 'Let'},
])
Department.delete_all
Department.create([
  {id: 1, value: 'For Sale'},
  {id: 2, value: 'To Let'}
])
Frequency.delete_all
Frequency.create([
  {id: 1, value: 'PCM'},
  {id: 2, value: 'PW'},
  {id: 3, value: 'PA'}
])
MediaType.delete_all
MediaType.create([
  {id: 1, value: 'Image'},
  {id: 2, value: 'EPC'},
  {id: 3, value: 'Floorplan'},
  {id: 4, value: 'Tours'}
])
Qualifier.delete_all
Qualifier.create([
  {id: 1, value: 'Asking Price Of'},
  {id: 2, value: 'Fixed Price'},
  {id: 3, value: 'From'},
  {id: 4, value: 'Guide Price'},
  {id: 5, value: 'Offers In The Region Of'},
  {id: 6, value: 'Offers Over'},
  {id: 7, value: 'Auction Guide Price'},
  {id: 8, value: 'Sale By Tender'},
  {id: 9, value: 'Shared Ownership'},
  {id: 10, value: 'Offers In Excess Of'},
  {id: 11, value: 'Offers Invited'},
  {id: 12, value: 'Starting Bid'},
])
SaleType.delete_all
SaleType.create([
  {id: 1, value: 'Not Specified'},
  {id: 2, value: 'Private Treaty'},
  {id: 3, value: 'By Auction'},
  {id: 4, value: 'Confidential'},
  {id: 5, value: 'By Tender'},
  {id: 6, value: 'Offers Invited'}
])
Style.delete_all
Style.create([
  {id: 1, value: 'Barn Conversion'},
  {id: 2, value: 'Cottage'},
  {id: 3, value: 'Chalet'},
  {id: 4, value: 'Detached House'},
  {id: 5, value: 'Semi-Detached House'},
  {id: 6, value: 'Farm House'},
  {id: 7, value: 'Manor House'},
  {id: 8, value: 'Mews'},
  {id: 9, value: 'Mid Terraced House'},
  {id: 10, value: 'End Terraced House'},
  {id: 11, value: 'Town House'},
  {id: 12, value: 'Villa'},
  {id: 13, value: 'Link Detached'},
  {id: 14, value: 'Shared House'},
  {id: 15, value: 'Sheltered Housing'},
  {id: 16, value: 'Apartment'},
  {id: 17, value: 'Bedsit'},
  {id: 18, value: 'Ground Floor Flat'},
  {id: 19, value: 'Flat'},
  {id: 20, value: 'Ground Floor Maisonette'},
  {id: 21, value: 'Maisonette'},
  {id: 22, value: 'Penthouse'},
  {id: 23, value: 'Studio'},
  {id: 24, value: 'Studio Flat'},
  {id: 25, value: 'Detached Bungalow'},
  {id: 26, value: 'Semi-Detached Bungalow'},
  {id: 27, value: 'Mid Terraced Bungalow'},
  {id: 28, value: 'End Terraced Bungalow'},
  {id: 29, value: 'Building Plot / Land'},
  {id: 30, value: 'Garage'},
  {id: 31, value: 'House Boat'},
  {id: 32, value: 'Mobile Home'},
  {id: 33, value: 'Parking'},
  {id: 34, value: 'Equestrian'},
  {id: 35, value: 'Unconverted Barn'}
])
Tenure.delete_all
Tenure.create([
  {id:1, value: 'Not Specified'},
  {id:2, value: 'Freehold'},
  {id:3, value: 'Leasehold'},
  {id:4, value: 'Commonhold'},
  {id:5, value: 'Share of Freehold'},
  {id:6, value: 'Flying Freehold'},
  {id:7, value: 'Share Transfer'},
  {id:8, value: 'Unknown'}
])
Type.delete_all
Type.create([
  {id:1, value: 'Houses'},
  {id:2, value: 'Flats / Apartments'},
  {id:3, value: 'Bungalows'},
  {id:4, value: 'Other'}
])
User.delete_all
User.create([
  {
    id: 1,
    email: 'bob1@example.com',
    admin: 1,
    password: 'internet',
    password_confirmation: 'internet',
    confirmed_at: DateTime.now
  },
  {
    id: 2,
    email: 'bob2@example.com',
    admin: 0,
    password: 'internet',
    password_confirmation: 'internet',
    confirmed_at: DateTime.now
  }
])
Agent.delete_all
Agent.create([
  {id: 1, user_id: 1, name: 'Test Agent', status: 1}
])
Branch.delete_all
Branch.create([{
  id: 1,
  agent_id: 1,
  name: 'Agent Branch 1',
  address_1: 'Address Line 1',
  town_city: 'Town',
  county: 'County',
  postcode: 'TC1 1AA',
  country: 'United Kingdom',
  latitude: 54.937992,
  longitude: -2.742925,
  display_address: 'Address Line 1, Town, County'
}])
Listing.delete_all
Listing.create([
  id: 1,
  branch_id: 1,
  age_id: 1,
  availability_id: 1,
  department_id: 1,
  frequency_id: 1,
  qualifier_id: 1,
  sale_type_id: 1,
  style_id: 1,
  tenure_id: 1,
  type_id: 1,
  address_1: 'Address Line 1',
  town_city: 'Town',
  county: 'County',
  postcode: 'TC1 1AA',
  country: 'United Kingdom',
  latitude: 54.895884,
  longitude: -2.929181,
  display_address: 'Address Line 1, Town, County',
  bedrooms: 1,
  bathrooms: 1,
  ensuites: 1,
  receptions: 1,
  kitchens: 1,
  summary: 'I am a summary',
  description: 'I am a description',
  price: 100000,
])
