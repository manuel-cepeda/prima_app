module UsersHelper


	def avatar_for(user,width,height)

		picture_url="https://graph.facebook.com/#{user.fb_id}/picture?width=#{width}&height=#{height}"
		image_tag(picture_url, alt: user.name, class: "avatar")
	end

	def phrases(score)

     switch (score) {
         case (1):
          'Aburrido como ostra'
         break;
         case (2):
         'Prefiero contar ovejas'
         break;
         case (3):
         'Está que prende'
         break;
         case (4):
         'Tan bueno que me quemo'
         break;
         case (5):
         '¡Traigan agua que está en llamas!'
         break;
         default:
         'Si estás en este lugar, vota!'
     }
	end

end
