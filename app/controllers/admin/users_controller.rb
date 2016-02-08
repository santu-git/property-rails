class Admin::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def token

    current_user.api_token = SecureRandom.base64(64)
    
    if current_user.save
      flash[:notice] = 'Token updated successfully'
    else
      flash[:alert] = 'Unable to update token'
    end

    redirect_to :back

  end

end
