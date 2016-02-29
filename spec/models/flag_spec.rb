require 'rails_helper'

describe Flag do

  it 'is valid with a value of at least 3 characters' do
    flag = build(:flag)
    expect(flag).to be_valid
  end

  it 'is invalid with a missing listing' do
    flag = build(:flag, listing: nil)
    expect(flag).to be_invalid
  end

  it 'is invalid with a missing value' do
    flag = build(:flag, value: nil)
    expect(flag).to be_invalid
  end

  it 'is invalid with a value less than 3 characters' do
    flag = build(:flag, value: 'AA')
    expect(flag).to be_invalid
  end

  it 'is invalid with a value more than 50 characters' do
    flag = build(:flag, value: 'A' *  51)
    expect(flag).to be_invalid
  end

end
