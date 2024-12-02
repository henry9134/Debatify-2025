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
    def show
      @topic = Topic.find(params[:id])
      @user = current_user

      # Fetch all comments
      @comments = @topic.comments
      @main_comments = @comments.where(parent_id: nil)

      # Count votes for "For" and "Against"
      @for_votes = @main_comments.where(status: 'for').count
      @against_votes = @main_comments.where(status: 'against').count

      # Total votes
      total_votes = @for_votes + @against_votes

      # Calculate thermometer percentage
      max_votes = 100
      @thermometer_percentage = [total_votes.to_f / max_votes * 100, 100].min

      # Prepare a new comment object
      @comment = @topic.comments.build
    end


    # Generate summary using OpenAI (based on main comments only)
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [{ role: "user", content: "give me a summary of how the users feel based on the comments: #{@main_comments.map(&:content).join(', ')} only 300 characters maximum." }]
    })
    @content = chatgpt_response['choices'][0]['message']['content']

    # Prepare a new comment object for the form
    @comment = @topic.comments.build
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
