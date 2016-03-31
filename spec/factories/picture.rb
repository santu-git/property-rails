include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :picture do
    has_attached_file { fixture_file_upload(File.new(Rails.root.join('spec', 'fixtures', 'test.jpg')), 'image/jpeg') }
  end
end