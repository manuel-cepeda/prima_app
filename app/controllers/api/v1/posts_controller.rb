class Api::V1::PostsController < ApplicationController
  before_action :signed_in_user,   only: [:create, :destroy, :update]
  before_action :correct_user,   only: [:destroy]
  respond_to :json # default to Active Model Serializers

  def index
    respond_with Post.all
  end

  def show
    respond_with Post.find(params[:id])
  end

  def create
    #respond_with Post.create(post_params)
    @post = current_user.posts.build(post_params)
    @post.user_id=session[:user_id]
    @post.save

    respond_with @post
  end

  def update
    respond_with Post.update(params[:id], post_params)
  end

  def destroy
    respond_with Post.destroy(params[:id])
  end

  private
  def post_params
    params.require(:post).permit(:content, :user_id, :venue_id, :created_at) # only allow these for now
  end

  def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      return false unless (!@post.nil? || current_user.admin?)
  end

  def signed_in_user
      return false unless is_authenticated?
  end
end