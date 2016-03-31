FactoryGirl.define do
  factory :feature do
    listing{ build(:listing, department: build(:department)) }
    sequence(:value) { |n| "test#{n}" }
  end
end
