class Note < ActiveRecord::Base
  validates :content, :user_id, :track_id, presence: true
end
