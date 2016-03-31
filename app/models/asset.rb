class Asset < ActiveRecord::Base
  # Relations
  belongs_to :listing
  belongs_to :media_type
  # Validations
  has_attached_file :upload, styles:  lambda { |a| a.instance.upload_content_type =~ %r(image) ? {:crop => "200x120#", :small => "x200>", :medium => "x300>", :large => "x400>"}  : {} }
  validates_attachment :upload, presence: true, content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png', 'application/pdf'] }
  validates :status, presence: true
  # Scopes
  def self.belongs_to_current_user(current_user)
    self.joins(listing: [{branch: :agent}]).where(
      'agents.user_id = ?', current_user.id
    )
  end
end
