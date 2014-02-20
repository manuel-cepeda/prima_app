class Api::V1::RatingsController < ApplicationController
  respond_to :json # default to Active Model Serializers

  def index
    respond_with Rating.all

    
  end

  def show
    respond_with Rating.find(params[:id])
  end

  def create

     if is_authenticated?
   
      final_hash=rating_params.merge(:user_id => session[:user_id])

        @rating = Rating.find_by_user_id_and_venue_id(final_hash[:user_id],final_hash[:venue_id])
     
     #check if rating exists, if exists delete it
      if !@rating.blank?
       
         @rating.destroy();
      
      end

      respond_with Rating.create(final_hash)

     end

  end

  def update
     if is_authenticated?
    final_hash=rating_params.merge(:user_id => session[:user_id])
    respond_with Rating.update(params[:id], final_hash)
     end
  end

  def destroy
    respond_with Rating.destroy(params[:id])
  end

  private
  def rating_params
    params.require(:rating).permit(:score, :venue_id) # only allow these for now
  end
end