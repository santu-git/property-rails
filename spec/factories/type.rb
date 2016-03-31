FactoryGirl.define do
  factory :type do
    sequence(:value) { |n| "test#{n}" }
  end
end
