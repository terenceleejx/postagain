class HomeController < ApplicationController
	before_action :authenticate_user!
  before_filter :set_no_cache
	helper_method :buffer_post
  def index
  end
  def buffer_post(profile_ids, text)
  	client = Buff::Client.new(Figaro.env.buffer_access_token)
    client.create_update(options = {body: {profile_ids: profile_ids, text: text}})
  end
  def buffer_scan
    Delayed::Job.enqueue BufferPostsUpdate.new
    redirect_to root_path
  end
  def set_no_cache
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end