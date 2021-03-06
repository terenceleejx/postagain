class BufferPostsUpdate < Struct.new(:current_user_id)
	def perform
	  client = Buff::Client.new(User.find_by(uid: current_user_id).buffer_token)
	  profiles_data = client.profiles
	  profile_ids = Array.new
	  # Save profile ids from each social media account to an array.
	  profiles_data.each do |profile_data|
	  	profile_ids.push(profile_data[:id])
	  end
	  # Retrieve 100 updates (max allowed by API) from each social media account.
	  new_post = 0
	  updated_post = 0
	  profile_ids.each do |profile_id|
	    updates = client.updates_by_profile_id(profile_id, options = {count: 100, :status => "sent"})
	    # first key in updates hash reveals the total number of updates
	    updates["updates"].each do |update|
	  		added_key = 0
	 		  exclude = false
	 		  # check if post stats are zero
	    	if update["profile_service"] == "linkedin" || update["profile_service"] == "twitter"
	    		update["statistics"].each do |key, value|
	    		  if value == 0
	    			  added_key += 1
	    			end
	    		end
	    		if added_key == 4
	    		  exclude = true
	    		end
	    	elsif update["profile_service"] == "facebook"
	    		update["statistics"].each do |key, value|
	    		  if value == 0
	    			  added_key += 1
	    			end
	    		end
	    		if added_key == 2
	    		  exclude = true
	    		end
	    	end
	    	if exclude == false
		    	if !Post.exists?(:buffer_post_id => update["id"]) == true
		    		Post.create({
		    			text: update["text_formatted"],
		    			user_id: User.find_by(uid: current_user_id).id,
		    			profile_id: update["profile_id"],
		    			buffer_post_id: update["id"],
		    			buffer_user_id: update["user_id"],
		    			created_at: update["created_at"],
		    			day: update["day"],
		    			due_at: update["due_at"],
		    			due_time: update["due_time"],
		    			sent_at: update["sent_at"],
		    			media: update["media"],
		    			statistics: update["statistics"],
		    			profile_service: update["profile_service"]
		    		})
		    		new_post += 1
		    	else
		    		existing_post = Post.where(buffer_post_id: update["id"])
		    		# Update statistics for existing post only if it was changed and if it is less than a week old.
		    		if Time.at(update["sent_at"]) >= (Time.now - 604800).to_date
		    		  Post.update(existing_post.select("id"), statistics: update["statistics"])
		    		  updated_post += 1
		    		end
		    	end
		    end
	    end
	  end
    puts "#{new_post} posts saved."
    puts "#{updated_post} posts updated."
	end
end