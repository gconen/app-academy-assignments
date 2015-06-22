class ChangeDefaultsToFalse < ActiveRecord::Migration
  def change
    change_column :goals, :privacy, :boolean, default: false
    change_column :goals, :completed, :boolean, default: false
  end
end
