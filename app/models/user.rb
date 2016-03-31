class User < ActiveRecord::Base
  before_create :generate_api_token
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

  protected
    def generate_api_token
      self.api_token = SecureRandom.base64(64)
    end

end
