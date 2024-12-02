class RemoveCommentReferenceFromComments < ActiveRecord::Migration[7.1]
  def change
    remove_column :comments, :comment_id
  end
end
