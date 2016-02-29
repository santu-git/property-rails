require 'rails_helper'

describe Qualifier do
  it 'is valid with a value of at least 3 characters' do
    qualifier = build(:qualifier)
    expect(qualifier).to be_valid
  end
  it 'is invalid with a missing value' do
    qualifier = build(:qualifier, value: nil)
    expect(qualifier).to be_invalid
  end
  it 'is invalid with a value less than 3 characters' do
    qualifier = build(:qualifier, value: 'A' * 2)
    expect(qualifier).to be_invalid
  end
  it 'is invalid with a value of more than 50 characters' do
    qualifier = build(:qualifier, value: 'A' * 51)
    expect(qualifier).to be_invalid
  end
  it 'is invalid with a duplicate value' do
    qualifier1 = create(:qualifier, value: 'A' * 3)
    qualifier2 = build(:qualifier, 'value': 'A' * 3)
    expect(qualifier2).to be_invalid
  end
end
