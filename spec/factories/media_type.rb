FactoryGirl.define do
  factory :media_type do
    sequence(:value) { |n| "test#{n}" }
  end
end
