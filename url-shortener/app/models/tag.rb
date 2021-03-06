class Tag < ActiveRecord::Base
  belongs_to(
    :topic,
    class_name: 'TagTopic',
    foreign_key: :topic_id,
    primary_key: :id
  )

  belongs_to(
    :url,
    class_name: 'ShortenedUrl',
    foreign_key: :url_id,
    primary_key: :id
  )
end
