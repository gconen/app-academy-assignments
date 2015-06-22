class UpdateUser < ActiveRecord::Migration
  def up
    remove_column :users, :name
    remove_column :users, :email

    add_column :users, :username, :string, null: false, default: 'unknown'
    add_index :users, :username, unique: true
  end

  def down
    add_column :users, :name, :string, null: false, default: 'unknown'
    add_column :users, :email, :string, null: false, default: 'unknown'

    remove_column :users, :username
  end
end
