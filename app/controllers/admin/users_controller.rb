class Admin::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  end
  
  def token
    current_user.api_token = SecureRandom.base64(24)
    if current_user.save
      flash[:notice] = 'Token successfully changed'
    else
      flash[:alert] = 'Unable to change token'
    end
    redirect_to :back
  end

end