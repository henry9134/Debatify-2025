class RepliesController < ApplicationController

  def create
    reply = Comment.new(reply_params)
    reply.user = current_user

    if reply.save
      redirect_to topic_path(reply.topic), notice: "Comment added successfully"
    else
      redirect_to topic_path(reply.topic), alert: "Failed to add comment"
    end
  end

  private

  def reply_params
  params.permit(:content, :topic_id)
  end
end
