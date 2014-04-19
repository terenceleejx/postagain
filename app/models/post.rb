class Post < ActiveRecord::Base
	serialize :statistics
	belongs_to :user
end