class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :comments, foreign_key: :parent_id
  has_many :votes, dependent: :destroy

  enum status: { against: "against", neutral: "neutral", for: "for" }
end
