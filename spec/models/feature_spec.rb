require 'rails_helper'

describe Feature do

  it 'is valid with a value of at least 3 characters' do
    feature = build(:feature)
    expect(feature).to be_valid
  end

  it 'is invalid with a missing listing' do
    feature = build(:feature, listing: nil)
    expect(feature).to be_invalid
  end

  it 'is invalid with a missing value' do
    feature = build(:feature, value: nil)
    expect(feature).to be_invalid
  end

  it 'is invalid with a value less than 3 characters' do
    feature = build(:feature, value: 'AA')
    expect(feature).to be_invalid
  end

  it 'is invalid with a value more than 50 characters' do
    feature = build(:feature, value: 'A' *  51)
    expect(feature).to be_invalid
  end

end
