class Topic < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  acts_as_favoritable
  include PgSearch::Model

  pg_search_scope :search_topics,
    against: [ :title, :description, :category ],
    using: {
      tsearch: { prefix: true },
    }
    
end
