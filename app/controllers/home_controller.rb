class HomeController < ApplicationController
	before_action :authenticate_user!
	helper_method :buffer_post
  def index
  end
  def buffer_post(profile_ids, text)
  	client = Buff::Client.new(Figaro.env.buffer_access_token)
    client.create_update(options = {body: {profile_ids: profile_ids, text: text}})
  end
  def buffer_scan
    Delayed::Job.enqueue BufferPostsUpdate.new(current_user.id)
    redirect_to root_path
  end
end