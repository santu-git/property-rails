FactoryGirl.define do
  factory :style do
    sequence(:value) { |n| "test#{n}" }
  end
end
