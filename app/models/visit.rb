class Visit < ActiveRecord::Base
  validates :user_id, presence: true
  validates :url_id, presence: true

  belongs_to(
    :url,
    class_name: "ShortenedUrl",
    foreign_key: :url_id,
    primary_key: :id
  )

  belongs_to(
    :visitor,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )
end
