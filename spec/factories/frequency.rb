FactoryGirl.define do
  factory :frequency do
    sequence(:value) { |n| "test#{n}" }
  end
end
