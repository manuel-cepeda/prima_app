class SessionsController < ApplicationController
    def new

         if params[:code]
            # acknowledge code and get access token from FB
            session[:access_token] = session[:oauth].get_access_token(params[:code])
        end 
 
        # auth established, now do a graph call:
        @api = Koala::Facebook::API.new(session[:access_token])
 
        begin
            @user_profile = @api.get_object(current_user.fb_id)
        rescue Exception=>ex
            puts ex.message
            #if user is not logged in and an exception is caught, redirect to the page where logging in is requested
            redirect_to '/logins' and return
        end
 
        respond_to do |format|
         format.html {   }   
        end

    end


    def logins
        session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + '/')
        @auth_url =  session[:oauth].url_for_oauth_code(:permissions=>"read_stream publish_stream") 

        redirect_to @auth_url
    end



	def create
	  auth_hash = request.env['omniauth.auth']
	 

	  if session[:user_id]
	    # Means our user is signed in. Add the authorization to the user

	    user=User.find(session[:user_id]);
	    auth = user.add_provider(auth_hash)
	   
        
        
	  else
	    # Log him in or sign him up
	    auth = Authorization.find_or_create(auth_hash)
	 
	    # Create the session
	    session[:user_id] = auth.user.id
	    session['fb_access_token'] = auth_hash['credentials']['token']
	 	
	  end

       #say friend is a new user
      if session["fb_access_token"].present?
          @graph = Koala::Facebook::API.new(session["fb_access_token"])

          profile = @graph.get_object("me")
          @graph.put_connections("me", "feed", :message => "#{current_user.name} es un nuevo usuario en Crowdly! #{root_url}")
      end

	  redirect_to root_url, :success => "Signed in!"

	end

	def failure
	  render :text => "Sorry, but you didn't allow access to our app!"
	end

	def destroy
	  sign_out
      redirect_to root_url, :success => "Signed out!"
	end



end
