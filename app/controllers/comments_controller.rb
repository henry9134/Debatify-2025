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
      messages: [{ role: "user", content: "Please analyze the following comment and provide feedback as follows:
1. **Rating**: Based on the comment, rate its quality as one of the following: terrible, Bad, Average, or Good, Excellent. a good rated comment is one that tells a good, honest opinion and one that adds value to the conversation, dont be too strict on the rating.
2. **Improvement Advice**: - If the comment is rated below excellent, provide constructive advice on how the comment can be improved. - If the comment is rated Excellent, Don't display any feedback, just the rating. make your analysis max 100 characters. Here is the comment for analysis: #{params[:comment]} Format your response like this: - Rating: [Your rating here] - Feedback (dont display this if its excellent): [Your advice or confirmation here] "}]
    })
    content = chatgpt_response['choices'][0]['message']['content']

    render json: { analysis: content }
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :status, :parent_id)
  end
end
