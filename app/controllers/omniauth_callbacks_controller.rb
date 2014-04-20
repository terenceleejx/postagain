class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    User.from_omniauth(request.env["omniauth.auth"], current_user.email)
    redirect_to :root
  end
  alias_method :buffer, :all
end