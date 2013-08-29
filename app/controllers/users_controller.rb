class UsersController < ApplicationController
  def new
  end

  def show
    @user=User.find(params[:id])
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :gender)
    end

end
