FactoryGirl.define do
  factory :sale_type do
    sequence(:value) { |n| "test#{n}" }
  end
end
