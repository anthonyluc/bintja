class AddAttributesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :nickname, :string
    add_column :users, :description, :text
    add_column :users, :avatar, :string
    add_column :users, :admin, :boolean, null: false, default: false
    add_index :users, :admin
    add_column :users, :admin_level, :integer, null: true
    add_column :users, :blocked, :boolean, default: false
    add_index :users, :blocked
    add_column :users, :blocked_since, :datetime
  end
end
