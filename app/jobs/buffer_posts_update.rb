class BufferPostsUpdate < Struct.new(:current_user_id)
	def perform
	  client = Buff::Client.new(Figaro.env.buffer_access_token)
	  profiles_data = client.profiles
	  profile_ids = Array.new
	  # Save profile ids from each social media account to an array.
	  profiles_data.each do |profile_data|
	  	profile_ids.push(profile_data[:id])
	  end
	  # Retrieve 100 updates (max allowed by API) from each social media account.
	  number = 0
	  profile_ids.each do |profile_id|
	    updates = client.updates_by_profile_id(profile_id, options = {count: 100, :status => "sent"})
	    # Save update in db if update is over 7 days old and does not exist in db.
	    # first key in updates hash reveals the total number of updates
	    updates["updates"].each do |update|
	    	if !Post.exists?(:buffer_post_id => update["id"]) == true
	    		Post.create({
	    			text: update["text"],
	    			user_id: current_user_id,
	    			profile_id: update["profile_id"],
	    			buffer_post_id: update["id"],
	    			buffer_user_id: update["user_id"],
	    			created_at: update["created_at"],
	    			day: update["day"],
	    			due_at: update["due_at"],
	    			due_time: update["due_time"],
	    			statistics: update["statistics"],
	    			profile_service: update["profile_service"]
	    		})
	    		number += 1
	    	else
	    	end
	    end
	  end
    puts "#{number} posts saved."
	end
end