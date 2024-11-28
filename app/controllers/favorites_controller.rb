class FavoritesController < ApplicationController
  before_action :authenticate_user! # Ensure only logged-in users can favorite/unfavorite

  def create
    @topic = Topic.find(params[:topic_id])
    current_user.favorite(@topic) unless current_user.favorited?(@topic)
    respond_to do |format|
      format.html { redirect_to topic_path(@topic), notice: 'Topic has been added to your favorites!' }
      format.json { render json: { favorited: true } }
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    current_user.unfavorite(@topic) if current_user.favorited?(@topic)
    respond_to do |format|
      format.html { redirect_to topic_path(@topic), notice: 'Topic has been removed from your favorites.' }
      format.json { render json: { favorited: false } }
    end
  end
end
