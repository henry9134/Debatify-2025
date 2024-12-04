class Topic < ApplicationRecord
  belongs_to :user
  has_many :comments,dependent: :destroy
  acts_as_favoritable

  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :category, presence: true

  include PgSearch::Model

  pg_search_scope :search_topics,
    against: [ :title, :description, :category ],
    using: {
      tsearch: { prefix: true },
    }


end
