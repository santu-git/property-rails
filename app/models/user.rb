class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
  :trackable, :validatable, :confirmable, :lockable

  # Relations
  has_many :agents
end
