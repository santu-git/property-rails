class Agent < ActiveRecord::Base
  belongs_to :user
  has_many :branches
  has_many :listings

  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :name, presence: true, length: { in: 3..50 }
  validates :status, presence: true, numericality: { only_integer: true }
end
