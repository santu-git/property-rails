class Style < ActiveRecord::Base
  # Relations
  has_many :listings
  # Validations
  validates :value, presence: true, length: { in: 3..50 }, uniqueness: true
end
