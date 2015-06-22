class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name, null: false
      t.string :body, null: false
      t.integer :user_id, null: false
      t.boolean :private, null: false
      t.boolean :completed, null: false

      t.timestamps null: false
    end
    add_index :goals, :user_id
    add_index :goals, [:user_id, :name], unique: true

  end
end
