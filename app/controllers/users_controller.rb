class UsersController < ApplicationController
  def new
  end

  def show
    @user=User.find(params[:id])

@graph = Koala::Facebook::API.new(session["fb_access_token"])

profile = @graph.get_object("me")
friends = @graph.get_connections("me", "friends")
@graph.put_connections("me", "feed", :message => "I am writing on my wall!")


  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :gender)
    end

end
