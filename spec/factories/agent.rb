FactoryGirl.define do
  factory :agent do
    user
    sequence(:name) { |n| "test#{n}" }
    status 1
  end
end
