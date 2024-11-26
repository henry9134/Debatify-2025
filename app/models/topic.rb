class Topic < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  acts_as_favoritable
end
