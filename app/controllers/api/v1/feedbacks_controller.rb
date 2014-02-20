class Api::V1::FeedbacksController < ApplicationController
  respond_to :json # default to Active Model Serializers

  def index
    respond_with Feedback.all
  end

  def show
    respond_with Feedback.find(params[:id])
  end

  def create
    respond_with Feedback.create(feedback_params)
  end

  def update
    respond_with Feedback.update(params[:id], feedback_params)
  end

  def destroy
    respond_with Feedback.destroy(params[:id])
  end

  private
  def feedback_params
    params.require(:feedback).permit(:description) # only allow these for now
  end
end
