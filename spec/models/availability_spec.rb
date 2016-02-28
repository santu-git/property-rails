require 'rails_helper'

describe Availability do
  it 'is valid with a value of at least 3 characters' do
    availability = Availability.new(value: 'A' * 3)
    expect(availability).to be_valid
  end
  it 'is invalid with a value less than 3 characters' do
    availability = Availability.new(value: 'A' * 2)
    expect(availability).to be_invalid
  end
  it 'is invalid with a value of more than 50 characters' do
    availability = Availability.new(value: 'A' * 51)
    expect(availability).to be_invalid
  end
  it 'is invalid with a duplicate value' do
    availability1 = Availability.create('value': 'A' * 3)
    availability2 = Availability.new('value': 'A' * 3)
    expect(availability2).to be_invalid    
  end
end
