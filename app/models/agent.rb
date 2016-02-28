class Agent < ActiveRecord::Base
  # Relations
  belongs_to :user
  has_many :branches
  has_many :listings
  # Validations
  validates :user, presence: true
  validates :name, presence: true, length: { in: 3..50 }
  validates :status, presence: true, numericality: { only_integer: true }
  # Scopes
  def self.belongs_to_current_user(current_user)
    self.where(
      'user_id = ?', current_user.id
    )
  end
end
