class CommentsController < ApplicationController

  def create
  end

  def upvote
    @comment = Comment.find(params[:id])
    if current_user.voted_on?(@comment)
      @comment.votes -= 1
      current_user.remove_vote(@comment)
    else
      @comment.votes += 1
      current_user.upvote(@comment)
    end
    @comment.save
    redirect_to topic_path(@comment.topic)
  end

end
