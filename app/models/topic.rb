class Topic < ApplicationRecord
  belongs_to :user
  acts_as_favoritable
end
