class PostsController < ApplicationController
  before_action :signed_in_user

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
  end

  private

    def post_params
      params.require(:post).permit(:content)
    end


end