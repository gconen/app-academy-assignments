class AddEnvToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :env, :string
    add_column :sessions, :ip, :string
  end
end
