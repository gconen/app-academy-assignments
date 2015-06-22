class TagTopic < ActiveRecord::Base
  has_many(
    :tags,
    class_name: 'Tag',
    foreign_key: :topic_id,
    primary_key: :id
  )

  has_many(
    :urls,
    through: :tags,
    source: :url
  )

  def most_popular(n = 1)
    urls
      .joins("INNER JOIN visits ON visits.url_id = shortened_urls.id")
      .group("shortened_urls.id")
      .order("COUNT(DISTINCT visits.user_id) DESC")
      .take(n)
  end
end
