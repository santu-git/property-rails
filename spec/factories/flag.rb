FactoryGirl.define do
  factory :flag do
    listing{ build(:listing, department: build(:department)) }
    sequence(:value) { |n| "test#{n}" }
  end
end
