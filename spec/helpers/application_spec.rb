require 'rails_helper'

describe ApplicationHelper do
  describe '#is_admin?' do
    it 'returns true' do
      user = create(:admin)
      sign_in user
      expect(helper.is_admin?).to be_truthy
    end
    it 'returns false' do
      user = create(:user)
      sign_in user
      expect(helper.is_admin?).to be_falsey
    end
  end
  describe '#paperclip_icon_url' do
    it 'returns font-awesome classes for application/pdf' do
      field = double('field')
      allow(field).to receive(:content_type).and_return('application/pdf')
      expect(helper.paperclip_icon_url(field)).to eq 'fa fa-file-pdf-o'
    end 
    it 'returns font-awesome classes for image/jpg' do
      field = double('field')
      allow(field).to receive(:content_type).and_return('image/jpg')
      expect(helper.paperclip_icon_url(field)).to eq 'fa fa-file-image-o'
    end   
    it 'returns font-awesome classes for image/jpeg' do
      field = double('field')
      allow(field).to receive(:content_type).and_return('image/jpeg')
      expect(helper.paperclip_icon_url(field)).to eq 'fa fa-file-image-o'
    end  
    it 'returns font-awesome classes for image/png' do
      field = double('field')
      allow(field).to receive(:content_type).and_return('image/png')
      expect(helper.paperclip_icon_url(field)).to eq 'fa fa-file-image-o'
    end   
    it 'returns font-awesome classes for image/gif' do
      field = double('field')
      allow(field).to receive(:content_type).and_return('image/gif')
      expect(helper.paperclip_icon_url(field)).to eq 'fa fa-file-image-o'
    end  
    it 'returns font-awesomee classes for other file' do
      field = double('field')
      allow(field).to receive(:content_type).and_return('application/other')
      expect(helper.paperclip_icon_url(field)).to eq 'fa fa-file-o'
    end              
  end
  describe '#is_image?' do
    it 'returns false for application/pdf' do
      field = double('field')
      allow(field).to receive(:content_type).and_return('application/pdf')
      expect(helper.is_image?(field)).to be_falsey
    end 
    it 'returns true for image/jpg' do
      field = double('field')
      allow(field).to receive(:content_type).and_return('image/jpg')
      expect(helper.is_image?(field)).to be_truthy
    end   
    it 'returns true for image/jpeg' do
      field = double('field')
      allow(field).to receive(:content_type).and_return('image/jpeg')
      expect(helper.is_image?(field)).to be_truthy
    end  
    it 'returns true for image/png' do
      field = double('field')
      allow(field).to receive(:content_type).and_return('image/png')
      expect(helper.is_image?(field)).to be_truthy
    end   
    it 'returns true for image/gif' do
      field = double('field')
      allow(field).to receive(:content_type).and_return('image/gif')
      expect(helper.is_image?(field)).to be_truthy
    end  
    it 'returns false for other file' do
      field = double('field')
      allow(field).to receive(:content_type).and_return('application/other')
      expect(helper.is_image?(field)).to be_falsey
    end              
  end

end