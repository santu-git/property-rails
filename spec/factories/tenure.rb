FactoryGirl.define do
  factory :tenure do
    sequence(:value) { |n| "test#{n}" }
  end
end
