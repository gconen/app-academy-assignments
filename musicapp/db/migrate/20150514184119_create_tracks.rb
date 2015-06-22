class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :album_id, null: false
      t.string :title
      t.text :lyrics
      t.boolean :bonus, default: false

      t.timestamps null: false
    end

    add_index :tracks, :album_id
    add_index :tracks, :title
  end
end
