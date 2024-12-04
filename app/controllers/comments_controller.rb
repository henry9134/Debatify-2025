class CommentsController < ApplicationController
  # after_initialize :set_default_votes, if: :new_record?


  def new


  end

  def create
    @topic = Topic.find(params[:topic_id])
    @comments = @topic.comments
    @comment = Comment.new
    @new_comment = @topic.comments.build(comment_params)
    @new_comment.user = current_user
    # when adding a reply to a reply we also need the parent of the parent
    # @parent = params[:reply].present? ? @new_comment.parent.parent : @new_comment.parent
    if @new_comment.save
      if @new_comment.parent_id.present?
        respond_to do |format|
          format.turbo_stream do
            partial = @new_comment.parent.parent_id.present? ? "topics/second_reply_form" : "topics/reply"
            render turbo_stream: turbo_stream.replace(
              "replies_turbo_#{ @new_comment.parent.id }",
              partial: partial,
              locals: { comment: @new_comment.parent, new_comment: Comment.new, expanded: true }
            )
          end
          format.html { redirect_to @new_comment.parent, notice: "Reply created successfully." }
        end
      else
        redirect_to @new_comment.topic, notice: "Reply created successfully."
      end
    else
      render 'topics/show', status: :unprocessable_entity
    end
  end

  def upvote
    @comment = Comment.find(params[:id])
    if current_user.voted_on?(@comment)
      current_user.remove_vote(@comment)
    else
      current_user.upvote(@comment)
    end
    respond_to do |format|
      format.html { redirect_to topic_path(@comment.topic) }
      format.json
    end
  end

  def analyse
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [{ role: "user", content: "you will analyse my comment. 
      First you will rate me based only on this : bad, average or good.
      Then if my comments was bad or average you will give me addvice how I can improve,
      but if my comment is good just confirm that my message is good. 
      here the comment you need to analyse : #{params[:comment]}" }]
    })
    content = chatgpt_response['choices'][0]['message']['content']

    render json: { analysis: content }
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :status, :parent_id)
  end
end
