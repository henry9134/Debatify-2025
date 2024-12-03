class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  has_one_attached :photo
  has_many :topics
  has_many :comments
  acts_as_favoritor
  has_many :votes

  def votes
    Vote.where(user_id: id)
  end

  # Define the voted_on? method
  def voted_on?(comment)
    votes.exists?(comment_id: comment.id)
  end

  def comment_belongs_to_current_user?(comment)
    comment.user_id == id
  end

  # Method to upvote a comment
  def upvote(comment)
    unless voted_on?(comment) ||comment_belongs_to_current_user?(comment)
      votes.create(comment: comment)
    end
  end

  # Method to remove a vote from a comment
  def remove_vote(comment)
    vote = votes.find_by(comment: comment)
    vote.destroy if vote
  end
end
