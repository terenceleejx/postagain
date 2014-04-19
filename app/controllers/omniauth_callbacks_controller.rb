class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
  	@buffer_access_token = Figaro.env.buffer_access_token
    User.from_omniauth(request.env["omniauth.auth"], current_user.email)
    redirect_to :root
  end
  alias_method :buffer, :all
end
#post authorization message needs work. From 'You are already signed in' to something else