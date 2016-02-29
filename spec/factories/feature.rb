FactoryGirl.define do
  factory :feature do
    listing{ build(:listing, department: build(:department)) }
    value 'test'
  end
end
