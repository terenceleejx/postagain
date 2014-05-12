class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def buffer
    User.from_omniauth(request.env["omniauth.auth"], current_user.email)
    redirect_to :root
  end
end