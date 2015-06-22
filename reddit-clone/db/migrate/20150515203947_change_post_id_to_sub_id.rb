class ChangePostIdToSubId < ActiveRecord::Migration
  def change
    rename_column :posts, :post_id, :sub_id 
  end
end
