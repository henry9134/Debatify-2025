class AddPointToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :point, :integer, default: 0, null: false
  end
end
