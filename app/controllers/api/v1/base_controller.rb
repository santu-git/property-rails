class Api::V1::BaseController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :destroy_session

  def destroy_session
    request.session_options[:skip] = true
  end

  def authenticate_user!
    # Get the token and options (email) from header
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

    # Get the email from options otherwise provide a nil
    email = options.blank? ? nil : options[:email]

    # Try to find the user by the email
    user = email && User.find_by(email: email)

    # If the user was found and then token matches that stored for the user
    # then set the current_user instance variable to current_user otherwise return unauthenticated
    if user && ActiveSupport::SecurityUtils.secure_compare(user.api_token, token)
      @current_user = user
    else
      unauthenticated!
    end
  end

  def unauthenticated!
    response.headers['WWW-Authenticate'] = "Token realm=Application"
    render json: { error: 'Bad credentials' }, status: 401
  end

  def unauthorized!
    render json: { error: 'not authorized' }, status: 403
  end


end
