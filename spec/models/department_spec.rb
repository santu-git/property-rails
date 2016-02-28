require 'rails_helper'

describe Department do
  it 'is valid with a value of at least 3 characters' do
    department = Department.new(value: 'A' * 3)
    expect(department).to be_valid
  end
  it 'is invalid with a missing value' do
    department = Department.new(value: nil)
    expect(department).to be_invalid
  end
  it 'is invalid with a value less than 3 characters' do
    department = Department.new(value: 'A' * 2)
    expect(department).to be_invalid
  end
  it 'is invalid with a value of more than 50 characters' do
    department = Department.new(value: 'A' * 51)
    expect(department).to be_invalid
  end
  it 'is invalid with a duplicate value' do
    department1 = Department.create('value': 'A' * 3)
    department2 = Department.new('value': 'A' * 3)
    expect(department2).to be_invalid
  end
end
