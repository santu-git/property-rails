require 'rails_helper'

describe Tenure do
  it 'is valid with a value of at least 3 characters' do
    tenure = build(:tenure)
    expect(tenure).to be_valid
  end
  it 'is invalid with a missing value' do
    tenure = build(:tenure, value: nil)
    expect(tenure).to be_invalid
  end
  it 'is invalid with a value less than 3 characters' do
    tenure = build(:tenure, value: 'A' * 2)
    expect(tenure).to be_invalid
  end
  it 'is invalid with a value of more than 50 characters' do
    tenure = build(:tenure, value: 'A' * 51)
    expect(tenure).to be_invalid
  end
  it 'is invalid with a duplicate value' do
    tenure1 = create(:tenure, value: 'A' * 3)
    tenure2 = build(:tenure, value: 'A' * 3)
    expect(tenure2).to be_invalid
  end
end
