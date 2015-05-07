class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validate :email_valid

  has_many(
    :submitted_urls,
    class_name: 'ShortenedUrl',
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :visited_urls,
    -> { distinct },
    through: :visits,
    source: :url
  )

  def email_valid
    unless email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      errors[:email] << "invalid email"
    end
  end

end
