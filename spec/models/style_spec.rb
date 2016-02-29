require 'rails_helper'

describe Style do
  it 'is valid with a value of at least 3 characters' do
    style = build(:style)
    expect(style).to be_valid
  end
  it 'is invalid with a missing value' do
    style = build(:style, value: nil)
    expect(style).to be_invalid
  end
  it 'is invalid with a value less than 3 characters' do
    style = build(:style, value: 'A' * 2)
    expect(style).to be_invalid
  end
  it 'is invalid with a value of more than 50 characters' do
    style = build(:style, value: 'A' * 51)
    expect(style).to be_invalid
  end
  it 'is invalid with a duplicate value' do
    style1 = create(:style, value: 'A' * 3)
    style2 = build(:style, value: 'A' * 3)
    expect(style2).to be_invalid
  end
end
