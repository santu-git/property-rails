require 'rails_helper'

describe Frequency do
  it 'is valid with a value of at least 2 characters' do
    frequency = Frequency.new(value: 'A' * 2)
    expect(frequency).to be_valid
  end
  it 'is invalid with a missing value' do
    frequency = Frequency.new(value: nil)
    expect(frequency).to be_invalid
  end
  it 'is invalid with a value less than 2 characters' do
    frequency = Frequency.new(value: 'A')
    expect(frequency).to be_invalid
  end
  it 'is invalid with a value of more than 50 characters' do
    frequency = Frequency.new(value: 'A' * 51)
    expect(frequency).to be_invalid
  end
  it 'is invalid with a duplicate value' do
    frequency1 = Frequency.create('value': 'A' * 2)
    frequency2 = Frequency.new('value': 'A' * 2)
    expect(frequency2).to be_invalid
  end
end
