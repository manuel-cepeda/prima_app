class RatingsController < ApplicationController
  include UsersHelper
  def update
    @rating = Rating.find(params[:id])
    @venue= @rating.venue
    @user= @rating.user




			 #send information to user facebook 
	      if session["fb_access_token"].present?
	          @graph = Koala::Facebook::API.new(session["fb_access_token"])

	          profile = @graph.get_object("me")
	          @graph.put_connections("me", "feed", :message => "Voto que #{@venue.title} #{phrases(params[:score])}", :link => "#{root_url}", :picture => "http://www.krowdly.com/assets/good.png")

	      end





    if @rating.update_attributes(score: params[:score])
      respond_to do |format|
        format.js
      end
    end
  end

end