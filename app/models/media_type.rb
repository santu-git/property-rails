class MediaType < ActiveRecord::Base
  # Relations
  has_many :assets
  # Validations
  validates :value, presence: true, length: { in: 3..50 }, uniqueness: true
end
