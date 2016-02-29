FactoryGirl.define do
  factory :user do
    email 'user@example.com'
    password 'password'
    confirmed_at Time.now
  end
  factory :admin, class: User do
    email 'admin@example.com'
    password 'password'
    confirmed_at Time.now
    admin true
  end 
end
