FactoryGirl.define do
  factory :department do
    sequence(:value) { |n| "test#{n}" }
  end
end
