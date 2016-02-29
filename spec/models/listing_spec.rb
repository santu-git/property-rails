require 'rails_helper'

describe Listing do
  it 'is valid with letting required fields' do
    listing = build(:letting_listing)
    expect(listing).to be_valid
  end

  it 'is valid with sale required fields' do
    listing = build(:sale_listing)
    expect(listing).to be_valid
  end

  it 'is valid sale with department id of 1' do
    listing = build(:sale_listing)
    expect(listing.is_for_sale?).to be true
  end

  it 'is valid letting with department id of 2' do
    listing = build(:letting_listing)
    expect(listing.is_to_let?).to be true
  end
end
