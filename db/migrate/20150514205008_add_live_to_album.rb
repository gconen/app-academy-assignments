class AddLiveToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :live, :boolean, default: false
  end
end
