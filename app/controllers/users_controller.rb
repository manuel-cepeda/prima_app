class UsersController < ApplicationController
  def new
  end

  def show
    @user=User.find(params[:id])

@graph = Koala::Facebook::API.new("CAAKEldGnNEIBADQr6FB9Jz5itvSU4KiqHZCpmJbYsk6GmbSwa76wD8ZB6RGTIRiSpxNwPEQtZBI5sronm5AZBsjsbJ4SatZADTSdBSxztCb53uNCNkGCb1ZBS5EO2vkHOvOhG3b42sCB5Iqf87FHHZCfUEcOEmqAa0tXvj5Dtrc3AZDZD")

profile = @graph.get_object("me")
friends = @graph.get_connections("me", "friends")
@graph.put_connections("me", "feed", :message => "I am writing on my wall!")


  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :gender)
    end

end
