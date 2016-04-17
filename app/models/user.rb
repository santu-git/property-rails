class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable,
  :trackable, :validatable, :confirmable, :lockable

  # Relations
  has_many :agents

  # Methods
  def is_admin?
    self.admin
  end

end
