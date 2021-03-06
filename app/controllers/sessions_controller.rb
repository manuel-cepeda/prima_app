class SessionsController < ApplicationController
    def new



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


		
		@session_token= session['fb_access_token']
		@session_user_id=session[:user_id]
		#@user_id=session[:user_id]
	end




	def failure
	  render :text => "Sorry, but you didn't allow access to our app!"
	end

	def destroy
	  sign_out
	 
      redirect_to root_url, :success => "Signed out!"
	end





end

