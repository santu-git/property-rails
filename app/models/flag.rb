class Flag < ActiveRecord::Base
  # Relations
  belongs_to :listing
  # Validations
  validates :listing, presence: true
  validates :value, presence: true, length: { in: 3..50 }
end
