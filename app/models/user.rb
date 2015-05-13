class User < ActiveRecord::Base
  def self.find_by_credentials(username, password)
    user = find_by(username: username)
    if user && user.is_password?(password)
      return user
    end

    nil
  end

  attr_reader :password

  validates :username, :password_digest, presence: true
  validates :username, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many(
    :owned_cats,
    class_name: "Cat",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :cat_rental_requests,
    class_name: 'CatRentalRequest',
    foreign_key: :user_id,
    primary_key: :id
  )

    has_many(
      :sessions,
      class_name: 'Session',
      foreign_key: :user_id,
      primary_key: :id
    )

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    @password = password
  end
end
