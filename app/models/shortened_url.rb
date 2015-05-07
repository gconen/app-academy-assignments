class ShortenedUrl < ActiveRecord::Base
  validates :submitter_id, presence: true
  validates :long_url, presence: true
  validates :short_url, presence: true, uniqueness: true
  validate :not_too_frequent

  belongs_to(
    :submitter,
    class_name: 'User',
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :clicks,
    class_name: 'Visit',
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    -> { distinct },
    through: :clicks,
    source: :visitor
  )

  has_many(
    :tags,
    class_name: 'Tag',
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many(
    :topics,
    through: :tags,
    source: :topic
  )

  def self.random_code
    loop do
      random = SecureRandom.base64(16)
      return random unless ShortenedUrl.exists?(short_url: random)
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(
      submitter_id: user.id,
      long_url: long_url,
      short_url: ShortenedUrl.random_code
    )
  end

  def num_clicks
    clicks.count(:all)
  end

  def num_uniques
    vistors.count(:all)
  end

  def num_recent_uniques
    clicks.where("visits.created_at >= ?", 10.minutes.ago)
          .select(:user_id)
          .distinct
          .count(:all)
  end

  def launch
    Launchy.open(long_url)
  end

  def not_too_frequent
    if User.find(submitter_id).submitted_urls
        .where("shortened_urls.created_at > ?", 1.minute.ago)
        .count(:all) > 4
      errors[:timing] << "Wait a minute before creating another shortened url"
    end
  end

end
