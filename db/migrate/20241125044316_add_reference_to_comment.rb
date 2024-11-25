class AddReferenceToComment < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :comment, foreign_key: true, null: true
  end
end
