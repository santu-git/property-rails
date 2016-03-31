FactoryGirl.define do
  factory :qualifier do
    sequence(:value) { |n| "test#{n}" }
  end
end
