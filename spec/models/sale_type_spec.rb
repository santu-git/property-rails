require 'rails_helper'

describe SaleType do
  it 'is valid with a value of at least 3 characters' do
    saletype = SaleType.new(value: 'A' * 3)
    expect(saletype).to be_valid
  end
  it 'is invalid with a missing value' do
    saletype = SaleType.new(value: nil)
    expect(saletype).to be_invalid
  end
  it 'is invalid with a value less than 3 characters' do
    saletype = SaleType.new(value: 'A' * 2)
    expect(saletype).to be_invalid
  end
  it 'is invalid with a value of more than 50 characters' do
    saletype = SaleType.new(value: 'A' * 51)
    expect(saletype).to be_invalid
  end
  it 'is invalid with a duplicate value' do
    saletype1 = SaleType.create('value': 'A' * 3)
    saletype2 = SaleType.new('value': 'A' * 3)
    expect(saletype2).to be_invalid
  end
end
