class RenameColumnPrivate < ActiveRecord::Migration
  def change
    rename_column :goals, :private, :privacy
  end
end
