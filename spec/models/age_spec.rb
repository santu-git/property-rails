require 'rails_helper'

describe Age do
  it 'is valid with a value of at least 3 characters' do
    age = build(:age)
    expect(age).to be_valid
  end
  it 'is invalid with a missing value' do
    age = build(:age, value: nil)
    expect(age).to be_invalid
  end
  it 'is invalid with a value less than 3 characters' do
    age = build(:age, value: 'A' * 2)
    expect(age).to be_invalid
  end
  it 'is invalid with a value of more than 50 characters' do
    age = build(:age, value: 'A' * 51)
    expect(age).to be_invalid
  end
  it 'is invalid with a duplicate value' do
    age1 = create(:age, value: 'test')
    age2 = build(:age, value: 'test')
    expect(age2).to be_invalid
  end
end
