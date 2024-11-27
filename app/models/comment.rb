class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  belongs_to :comment, optional: true
  has_many :comments

  enum status: { against: "against", neutral: "neutral", for: "for" }
end
