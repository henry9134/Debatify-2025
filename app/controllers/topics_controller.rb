class TopicsController < ApplicationController

  def index
    if params[:query].present?
      @topics = Topic.search_topics(params[:query])
    else
      @topics = Topic.all
    end

    respond_to do |format|
      format.html # Default behavior for full page load
      format.text { render partial: "topics/card_topics", locals: { topics: @topics }, formats: [:html] }
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @comments = @topic.comments
    @comment = @topic.comments.build
    @new_comment = Comment.new
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(params_topics)
    @topic.user_id = current_user.id
    if @topic.save
      redirect_to topic_path(@topic)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def params_topics
    params.require(:topic).permit(:title, :description, :category)
  end

end
