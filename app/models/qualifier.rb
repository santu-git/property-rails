class Qualifier < ActiveRecord::Base
  validates :value, presence: true, length: { in: 3..50 }, uniqueness: true      
end
