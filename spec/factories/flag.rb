FactoryGirl.define do
  factory :flag do
    listing{ build(:listing, department: build(:department)) }
    value 'test'
  end
end
