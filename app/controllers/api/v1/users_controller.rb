class Api::V1::UsersController < ApplicationController
  respond_to :json, :text

  def index
    respond_with User.all
  end

  def show

          respond_with User.find(params[:id])

  end

  def account

   if is_authenticated?

      respond_with do |format|
        format.json {
          render :json => { "user_id" => session[:user_id] }
        }
      end

    end


  end

end