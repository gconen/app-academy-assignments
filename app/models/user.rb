class User < ActiveRecord::Base
  validates :email, :session_token, uniqueness: true
  validates :email, :session_token, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token
  has_many :notes

  attr_reader :password

  def self.find_by_credentials(credentials)
    user = User.find_by(email: credentials["email"])
    if user && user.is_password?(credentials["password"]) && user.activated
      return user
    end

    nil
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
