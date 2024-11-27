class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  belongs_to :comment, optional: true
  has_many :comments
  has_many :votes, dependent: :destroy

  enum status: { against: "against", neutral: "neutral", for: "for" }
end
