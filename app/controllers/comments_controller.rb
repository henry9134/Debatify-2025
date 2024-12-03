class CommentsController < ApplicationController
  # after_initialize :set_default_votes, if: :new_record?


  def new


  end

  def create
    @topic = Topic.find(params[:topic_id])
    @new_comment = @topic.comments.build(comment_params)
    @new_comment.user = current_user
    # when adding a reply to a reply we also need the parent of the parent
    @parent = params[:reply].present? ? @new_comment.parent.parent : @new_comment.parent
    if @new_comment.save
      if @new_comment.parent_id.present?
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace(
              "replies_turbo_#{ @parent.id }",
              partial: "topics/reply",
              locals: { comment: @parent, new_comment: Comment.new, expanded: true }
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
  private

  def comment_params
    params.require(:comment).permit(:content, :status, :parent_id)
  end
end
