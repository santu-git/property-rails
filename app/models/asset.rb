class Asset < ActiveRecord::Base
  # Relations
  belongs_to :listing
  # Validations
  has_attached_file :upload, styles:  lambda { |a| a.instance.upload_content_type =~ %r(image) ? {:small => "x200>", :medium => "x300>", :large => "x400>"}  : {} }
  validates_attachment :upload, presence: true, content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png', 'application/pdf'] }
  # Scopes
  def self.belongs_to_current_user(current_user)
    self.joins(listing: :agent).where(
      'agents.user_id = ?', current_user.id
    )
  end
end
