class DashboardsController < ApplicationController

  def dashboard
    @user = current_user
    @topics = @user.favorited_topics.sample(rand(3..5))
  end
end
