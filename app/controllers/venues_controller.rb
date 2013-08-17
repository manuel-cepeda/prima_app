class VenuesController < ApplicationController
  before_action :set_venue, only: [:show, :edit, :update, :destroy]
  before_action :admin_user,     only: :destroy
  before_action :correct_user,   only: :destroy
  include VenuesHelper
  # GET /venues
  # GET /venues.json
  def index
    #@venues = Venue.all

    @venues = venues_by_plus_minus_vote(params[:time])

  end

  # GET /venues/1
  # GET /venues/1.json
  def show

    @venue = Venue.find(params[:id])
    @posts = @venue.posts.paginate(page: params[:page])
    @post =  current_user.posts.build if signed_in?
    session[:venue_id] = @venue.id
  end

  # GET /venues/new
  def new
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
        format.html { redirect_to @venue, notice: 'Venue was successfully created.' }
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
        format.html { redirect_to @venue, notice: 'Venue was successfully updated.' }
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
     # current_user.vote_for(@venue = Venue.find(params[:id]))
      redirect_to [@venue]
      flash[:success] = "You have voted successfully"
    rescue ActiveRecord::RecordInvalid
      #Manage this to show user can't vote twice
      redirect_to [@venue]
      flash[:error] =  "You have already voted"
    end      
  end

  def vote_down
    begin
      current_user.vote_exclusively_against(@venue = Venue.find(params[:id]))
      #current_user.vote_against(@venue = Venue.find(params[:id]))
      redirect_to [@venue]
      flash[:success] = "You have voted successfully"
    rescue ActiveRecord::RecordInvalid
      #Manage this to show user can't vote twice
      redirect_to [@venue]
      flash[:error] =  "You have already voted"
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
      redirect_to root_url if @venue.nil?
    end

end
