class AllowLongerUrls < ActiveRecord::Migration
  def up
    change_column :shortened_urls, :long_url, :text
  end

  def down
    change_column :shortened_urls, :long_url, :string
  end
end
