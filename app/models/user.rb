class User < ActiveRecord::Base
  def self.find_by_credentials(username, password)
    user = find_by(username: username)
    if user && user.is_password?(password)
      return user
    end

    nil
  end

  attr_reader :password

  validates :username, :password_digest, :session_token, presence: true
  validates :username, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    @password = password
  end


  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
  end
end
