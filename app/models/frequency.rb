class Frequency < ActiveRecord::Base
  validates :value, presence: true, length: { in: 2..50 }, uniqueness: true  
end
