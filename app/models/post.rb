class Post < ActiveRecord::Base
	serialize :statistics
	serialize :media
	belongs_to :user
end