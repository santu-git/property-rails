require 'rails_helper'

describe Type do
  it 'is valid with a value of at least 3 characters' do
    type = Type.new(value: 'A' * 3)
    expect(type).to be_valid
  end
  it 'is invalid with a missing value' do
    type = Type.new(value: nil)
    expect(type).to be_invalid    
  end
  it 'is invalid with a value less than 3 characters' do
    type = Type.new(value: 'A' * 2)
    expect(type).to be_invalid
  end
  it 'is invalid with a value of more than 50 characters' do
    type = Type.new(value: 'A' * 51)
    expect(type).to be_invalid
  end
  it 'is invalid with a duplicate value' do
    type1 = Type.create('value': 'A' * 3)
    type2 = Type.new('value': 'A' * 3)
    expect(type2).to be_invalid
  end
end
