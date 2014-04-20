class BufferPostsUpdate < Struct.new(:value)
	def perform
	  client = Buff::Client.new(Figaro.env.buffer_access_token)
	  profiles_data = client.profiles
	  profile_ids = Array.new
	  profiles_data.each do |profile_data|
	  	profile_ids.push(profile_data[:id])
	  end
	  puts profile_ids
	end
end