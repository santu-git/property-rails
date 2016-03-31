include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :asset do
    listing
    media_type
    status 1
    factory :jpg_asset do
      upload { fixture_file_upload(File.new(Rails.root.join('spec', 'fixtures', 'test.jpg')), 'image/jpeg') }
    end
    factory :png_asset do
      upload { fixture_file_upload(File.new(Rails.root.join('spec', 'fixtures', 'test.jpg')), 'image/png') }
    end
    factory :gif_asset do
      upload { fixture_file_upload(File.new(Rails.root.join('spec', 'fixtures', 'test.gif')), 'image/gif') }
    end
    factory :pdf_asset do
      upload { fixture_file_upload(File.new(Rails.root.join('spec', 'fixtures', 'test.pdf')), 'application/pdf') }
    end
  end
end