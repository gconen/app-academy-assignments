class CreateTag < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :topic_id
      t.integer :url_id
      t.timestamps
    end
  end
end
