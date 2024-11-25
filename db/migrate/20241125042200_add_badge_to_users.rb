class AddBadgeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :badge, :string
    add_column :users, :name, :string
  end
end
