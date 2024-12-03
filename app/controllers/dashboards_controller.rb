class DashboardsController < ApplicationController

  def dashboard
    @user = current_user
    @topics = @user.favorited_topics.sample(rand(3..5))
    @users = User.all

    @point_topics_user = @user.topics.count
    @point_comments_user = @user.comments.count * 2
    @point_comments_upvote = Vote.where(comment_id: @user.comments.pluck(:id)).count * 5
    @user.point = @point_topics_user + @point_comments_user + @point_comments_upvote
  end
end
 