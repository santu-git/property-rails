FactoryGirl.define do
  factory :availability do
    sequence(:value) { |n| "test#{n}" }
  end
end
