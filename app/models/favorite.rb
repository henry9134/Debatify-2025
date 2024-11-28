# frozen_string_literal: true

class Favorite < ApplicationRecord
  extend ActsAsFavoritor::FavoriteScopes

  belongs_to :favoritable, polymorphic: true
  belongs_to :favoritor, polymorphic: true

  # Validation to ensure a user can only favorite an item once
  validates :favoritor_id, uniqueness: { scope: [:favoritable_id, :favoritable_type], message: 'has already favorited this item' }

  # Block a favorite (existing method)
  def block!
    update!(blocked: true)
  end

  # Check if the favoritable is a specific type
  def topic?
    favoritable_type == 'Topic'
  end

  def comment?
    favoritable_type == 'Comment'
  end

  # Scope to get all favorited topics for a specific user
  scope :topics_favorited_by, ->(user) { where(favoritor: user, favoritable_type: 'Topic') }

  # Class method to check if a specific user has favorited an item
  def self.favorited?(user, favoritable)
    exists?(favoritor: user, favoritable: favoritable)
  end
end
