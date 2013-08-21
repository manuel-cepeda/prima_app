class PostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :update]
  before_action :correct_user,   only: :destroy
  def create

    @post = current_user.posts.build(post_params)
    @post.venue_id=session[:venue_id]

    if @post.save
      flash[:success] = "Post created!"
 
    else
      flash[:fail] = "Post error!"	
     # render 'static_pages/home' aqui poner algo si falla el post
  
    end
      redirect_to venue_url(session[:venue_id])
  end

  def destroy
    @post.destroy
    redirect_to venue_url(session[:venue_id])
  end

  private

    def post_params
      params.require(:post).permit(:content)
    end


    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url unless (!@post.nil? || current_user.admin?)
    end

end