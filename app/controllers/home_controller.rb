class HomeController < ApplicationController
	before_action :authenticate_user!
	helper_method :buffer_post
  def index
  end
  def buffer_scan
    Delayed::Job.enqueue BufferPostsUpdate.new(current_user.uid)
    redirect_to root_path
  end
  def buffer_remove
    post = Post.find_by(buffer_post_id: params[:buffer_post_id])
    post.update(remove: true)
    redirect_to root_path
  end
end