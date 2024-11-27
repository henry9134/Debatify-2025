class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :comment
  validates :user_id, uniqueness: { scope: :comment_id }
  validate :user_can_only_upvote_once

  private

  def user_can_only_upvote_once
    if Vote.where(user_id: user_id, comment_id: comment_id).exists?
      errors.add(:base, "You can only upvote a comment once.")
    end
  end
end
