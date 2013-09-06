module UsersHelper


	def avatar_for(user,width,height)

		picture_url="http://graph.facebook.com/#{user.fb_id}/picture?width=#{width}&height=#{height}"
		image_tag(picture_url, alt: user.name, class: "avatar")
	end

end
