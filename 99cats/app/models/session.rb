class Session < ActiveRecord::Base
  validates :session_token, :user_id, presence: true

  def self.generate(user)
    token = SecureRandom::urlsafe_base64
    Session.create!(user_id: user.id, session_token: token)
  end

  belongs_to(
    :user,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )


end
