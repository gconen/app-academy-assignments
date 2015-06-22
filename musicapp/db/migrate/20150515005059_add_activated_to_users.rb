class AddActivatedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activated, :boolean, default: false
    User.all.each { |user| user.activated = true } #apparently doesn't do anything
    add_column :users, :actication_token, :string
  end
end
