class Api::V1::VenuesController < ApplicationController
  respond_to :json

  def index
    respond_with Venue.all
  end

  def show
    respond_with Venue.find(params[:id])
  end
end