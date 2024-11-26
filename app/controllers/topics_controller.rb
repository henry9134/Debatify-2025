class TopicsController < ApplicationController

  def index
    if params[:query].present?
      @topics = Topic.search_topics(params[:query])
    else
      @topics = Topic.all
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @comments = @topic.comments
  end
end
