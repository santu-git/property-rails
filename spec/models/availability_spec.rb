require 'rails_helper'

describe Availability do
  it 'is valid with a value of at least 3 characters' do
    availability = build(:availability)
    expect(availability).to be_valid
  end
  it 'is invalid with a missing value' do
    department = build(:availability, value: nil)
    expect(department).to be_invalid
  end
  it 'is invalid with a value less than 3 characters' do
    availability = build(:availability, value: 'A' * 2)
    expect(availability).to be_invalid
  end
  it 'is invalid with a value of more than 50 characters' do
    availability = build(:availability, value: 'A' * 51)
    expect(availability).to be_invalid
  end
  it 'is invalid with a duplicate value' do
    availability1 = create(:availability)
    availability2 = build(:availability)
    expect(availability2).to be_invalid
  end
end
