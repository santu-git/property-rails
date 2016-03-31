FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password 'password'
    confirmed_at Time.now
  end
  factory :admin, class: User do
    sequence(:email) { |n| "test#{n}@example.com" }
    password 'password'
    confirmed_at Time.now
    admin true
  end 
end
