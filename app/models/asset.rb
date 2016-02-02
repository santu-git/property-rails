class Asset < ActiveRecord::Base
  belongs_to :listing
  has_attached_file :upload, styles:  lambda { |a| a.instance.upload_content_type =~ %r(image) ? {:small => "x200>", :medium => "x300>", :large => "x400>"}  : {} }
  validates_attachment :upload, presence: true, content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png', 'application/pdf'] }
end
