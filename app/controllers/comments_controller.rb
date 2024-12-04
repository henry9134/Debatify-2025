def create
  @comment = Comment.new(comment_params)
  @comment.user = current_user
  @comment.topic = Topic.find(params[:topic_id])

  if @comment.save
    respond_to do |format|
      format.turbo_stream do
        if @comment.parent_id.present?
          # For replies
          render turbo_stream: turbo_stream.append(
            "replies-#{@comment.parent_id}",
            partial: "topics/reply",
            locals: { reply: @comment }
          )
        else
          # For main comments
          render turbo_stream: turbo_stream.append(
            "comments-section",
            partial: "topics/comment",
            locals: { comment: @comment, new_comment: Comment.new }
          )
        end
      end
      format.html { redirect_to @comment.topic, notice: "Comment added successfully." }
    end
  else
    respond_to do |format|
      format.html { render :new, status: :unprocessable_entity }
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "new_comment_form",
          partial: "topics/comment_form",
          locals: { topic: @topic, comment: @comment }
        )
      end
    end
  end
end

private

def comment_params
  params.require(:comment).permit(:content, :parent_id)
end
