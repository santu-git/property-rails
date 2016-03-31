require 'rails_helper'

describe Ckeditor::Picture do 
  include ActionDispatch::TestProcess

  it 'provides url for content' do

    data ||= fixture_file_upload('test.png', 'image/png')

    picture = Ckeditor.picture_model.new(:data => data)

    expect(picture.url_content).to include('test.png')
    
  end

end