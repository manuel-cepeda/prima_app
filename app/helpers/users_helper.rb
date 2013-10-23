module UsersHelper


	def avatar_for(user,width,height)

		picture_url="https://graph.facebook.com/#{user.fb_id}/picture?width=#{width}&height=#{height}"
		image_tag(picture_url, alt: user.name, class: "avatar")
	end

	def phrases(score)

			case score # a_variable is the variable we want to compare
			when 1    #compare to 1
			  "it was 1" 
			when 2    #compare to 2
			  "it was 2"
			when 3    #compare to 2
			  "it was 2"
			when 4    #compare to 2
			  "it was 2"
			when 5    #compare to 2
			  "it was 2"
			else
			  "it was something else"
			end
	end

end
