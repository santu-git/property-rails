require 'rails_helper'

describe Style do
  it 'is valid with a value of at least 3 characters' do
    style = Style.new(value: 'A' * 3)
    expect(style).to be_valid
  end
  it 'is invalid with a missing value' do
    style = Style.new(value: nil)
    expect(style).to be_invalid
  end
  it 'is invalid with a value less than 3 characters' do
    style = Style.new(value: 'A' * 2)
    expect(style).to be_invalid
  end
  it 'is invalid with a value of more than 50 characters' do
    style = Style.new(value: 'A' * 51)
    expect(style).to be_invalid
  end
  it 'is invalid with a duplicate value' do
    style1 = Style.create('value': 'A' * 3)
    style2 = Style.new('value': 'A' * 3)
    expect(style2).to be_invalid
  end
end
