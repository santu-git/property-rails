require 'rails_helper'

describe Qualifier do
  it 'is valid with a value of at least 3 characters' do
    qualifier = Qualifier.new(value: 'A' * 3)
    expect(qualifier).to be_valid
  end
  it 'is invalid with a missing value' do
    qualifier = Qualifier.new(value: nil)
    expect(qualifier).to be_invalid
  end
  it 'is invalid with a value less than 3 characters' do
    qualifier = Qualifier.new(value: 'A' * 2)
    expect(qualifier).to be_invalid
  end
  it 'is invalid with a value of more than 50 characters' do
    qualifier = Qualifier.new(value: 'A' * 51)
    expect(qualifier).to be_invalid
  end
  it 'is invalid with a duplicate value' do
    qualifier1 = Qualifier.create('value': 'A' * 3)
    qualifier2 = Qualifier.new('value': 'A' * 3)
    expect(qualifier2).to be_invalid
  end
end
