class VenuesController < ApplicationController
  before_action :set_venue, only: [:show, :edit, :update, :destroy]
  before_action :correct_user,   only: :destroy
  include VenuesHelper

  # GET /venues
  # GET /venues.json
  def index
    #@venues = Venue.all




  end

  def list
    #@venues = Venue.all

    @venues = venues_by_plus_minus_vote(params[:time])




  end


  def show

    @venue = Venue.find(params[:id])
    @posts = @venue.posts.paginate(page: params[:page], :per_page => 30)
    @post =  current_user.posts.build if signed_in?
    session[:venue_id] = @venue.id
    @positive_votes=@venue.get_positive_votes
    @negative_votes=@venue.get_negative_votes
    @total_votes=@venue.get_total_votes
  end

  # GET /venues/new
  def new
    @search_value=params[:search_value]
    @venue = Venue.new
  end

  # GET /venues/1/edit
  def edit
  end

  # POST /venues
  # POST /venues.json
  def create

   
    @venue = current_user.venues.build(venue_params) 

    respond_to do |format|
      if @venue.save
        format.mobile { redirect_to @venue, notice: 'Lugar exitosamente agregado.' }
        format.html { redirect_to @venue, notice: 'Lugar exitosamente agregado.' }
        format.json { render action: 'show', status: :created, location: @venue }
      else
        format.html { render action: 'new' }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /venues/1
  # PATCH/PUT /venues/1.json
  def update
    respond_to do |format|
      if @venue.update(venue_params)
        format.html { redirect_to @venue, notice: 'Lugar exitosamente actualizado.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    @venue.destroy
    flash[:success] = "venue destroyed"
    respond_to do |format|
      format.html { redirect_to venues_url }
      format.json { head :no_content }
    end
  end

  def vote_up
    begin
      current_user.vote_exclusively_for(@venue = Venue.find(params[:id])) 
    
       #send information to user facebook 
      if session["fb_access_token"].present?
          @graph = Koala::Facebook::API.new(session["fb_access_token"])

          profile = @graph.get_object("me")
          @graph.put_connections("me", "feed", :message => "Lo está pasando bien en #{@venue.title}", :link => "#{root_url}")

      end


     # current_user.vote_for(@venue = Venue.find(params[:id]))
      redirect_to [@venue]
      flash[:success] = "Hemos recibido tu voto!"
    rescue ActiveRecord::RecordInvalid
      #Manage this to show user can't vote twice
      redirect_to [@venue]
      flash[:error] =  "Ya habias votado"
    end      
  end

  def vote_down
    begin
      current_user.vote_exclusively_against(@venue = Venue.find(params[:id]))
       #send information to user facebook 
      if session["fb_access_token"].present?
          @graph = Koala::Facebook::API.new(session["fb_access_token"])

          profile = @graph.get_object("me")
          @graph.put_connections("me", "feed", :message => "Le gustaría estar en un lugar más entretenido que #{@venue.title}", :link => "#{root_url}")
      end

      #current_user.vote_against(@venue = Venue.find(params[:id]))
      redirect_to [@venue]
      flash[:success] = "Hemos recibido tu voto!"
      rescue ActiveRecord::RecordInvalid
      #Manage this to show user can't vote twice
      redirect_to [@venue]
      flash[:error] =  "Ya habias votado"
    end      
  end

  def data

    votes_number_positive=0
    votes_number_negative=0

    if(params.has_key?(:id))

      

      votes_number_positive=params[:votes_number_positive]
      votes_number_negative=params[:votes_number_negative]

       votes_number_positive=votes_number_positive.to_i
      votes_number_negative=votes_number_negative.to_i

      i = 0
      until i == votes_number_positive
        i += 1
        User.find(i+7).vote_exclusively_for(@venue = Venue.find(params[:id]))
      end

      i = 0
      until i == votes_number_negative
        i += 1
        User.find(i+30).vote_exclusively_against(@venue = Venue.find(params[:id]))
      end

    end
 
  end


  def vote

    @venues=[]
    @search_flag=false

      # If the search param with it's whitespace stripped off
      # actually has something left then search for it
      unless params[:search].nil? || params[:search].strip.empty?
          @search = Venue.search do
              fulltext params[:search]    
          end
          @venues = @search.results
          @search_flag=true
      end
      @search_value=params[:search]
      @venues
      

  end 


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue
      @venue = Venue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def venue_params
      params.require(:venue).permit(:title, :body, :lat, :lng)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def correct_user

      @venue = current_user.venues.find_by(id: params[:id])
      redirect_to(root_url) unless (current_user.admin? || !@venue.nil?)

    end

end
