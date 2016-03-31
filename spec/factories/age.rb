FactoryGirl.define do
  factory :age do
    sequence(:value) { |n| "test#{n}" }
  end
end
