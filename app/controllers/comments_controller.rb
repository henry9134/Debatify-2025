class CommentsController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id])
    @new_comment = @topic.comments.build(comment_params)
    @new_comment.user = current_user

    if @new_comment.save
      redirect_to topic_path(@topic), notice: 'Comment added successfully!'
    else
      render 'topics/show', status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :status)
  end

end
