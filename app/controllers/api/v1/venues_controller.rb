class Api::V1::VenuesController < ApplicationController
  before_action :signed_in_user,   only: [:create, :destroy, :update]
  before_action :correct_user,   only: [:destroy]
  respond_to :json

  def index

    if params[:query]
        @venues=[]
        @search_flag=false

          # If the search param with it's whitespace stripped off
          # actually has something left then search for it
          unless params[:query].nil? || params[:query].strip.empty?
              @search = Venue.search do
                  fulltext params[:query]    
              end
              @venues = @search.results
              @search_flag=true
          end
          @search_value=params[:query]
          respond_with @venues
          

    else

    @venues=Venue.joins(:ratings)
    .select("venues.id, venues.title, venues.body,
     venues.latitude, venues.longitude, venues.user_id,
     AVG(ratings.score) as average")
    .where('ratings.updated_at > ?', 5.hours.ago)
    .group("venues.id, venues.title")
    .order("average DESC").limit(12)

    respond_with @venues

    end  

    
  end

  def show
    respond_with Venue.find(params[:id])
  end

  def rating
    
	#avg_rating = Venue.find(params[:id]).average_rating
	#hash = {:avg_rating => avg_rating}

    respond_with Rating.all.where('updated_at > ?', 5.hours.ago)
  end

  def create

    @venue = current_user.venues.build(venue_params)
    @venue.user_id=session[:user_id]
    @venue.save

    respond_with @venue
  end

  def update
    respond_with Venue.update(params[:id], venue_params)
  end

  def destroy
    respond_with Venue.destroy(params[:id])
  end

  private
  def venue_params
    params.require(:venue).permit(:title, :body, :latitude, :longitude, :user_id) # only allow these for now
  end

  def correct_user
      @venue = current_user.venue.find_by(id: params[:id])
      return false unless (!@venue.nil? || current_user.admin?)
  end

  def signed_in_user
      return false unless is_authenticated?
  end

end