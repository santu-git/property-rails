require 'rails_helper'

describe MediaType do
  it 'is valid with a value of at least 3 characters' do
    mediatype = build(:media_type)
    expect(mediatype).to be_valid
  end
  it 'is invalid with a missing value' do
    mediatype = build(:media_type, value: nil)
    expect(mediatype).to be_invalid
  end
  it 'is invalid with a value less than 3 characters' do
    mediatype = build(:media_type, value: 'A' * 2)
    expect(mediatype).to be_invalid
  end
  it 'is invalid with a value of more than 50 characters' do
    mediatype = build(:media_type, value: 'A' * 51)
    expect(mediatype).to be_invalid
  end
  it 'is invalid with a duplicate value' do
    mediatype1 = create(:media_type, value: 'A' * 3)
    mediatype2 = build(:media_type, value: 'A' * 3)
    expect(mediatype2).to be_invalid
  end
end
