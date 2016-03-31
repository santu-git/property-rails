require 'rails_helper'

describe Ckeditor::AttachmentFile do 
  include ActionDispatch::TestProcess

  it 'provides url for content' do

    data ||= fixture_file_upload('test.pdf', 'application/pdf')

    attachment = Ckeditor.attachment_file_model.new(:data => data)

    expect(attachment.url_thumb).to include('pdf.gif')
    
  end

end