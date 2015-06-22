# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  body       :string           not null
#  user_id    :integer          not null
#  privacy    :boolean          default(FALSE), not null
#  completed  :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Goal < ActiveRecord::Base
  include Commentable
  validates :name, :body, :user_id, presence: true
  validates :name, uniqueness: { scope: :user_id }
  after_initialize :ensure_defaults
  belongs_to :user, inverse_of: :goals

  def ensure_defaults
    self.completed = false unless self.completed
    self.privacy = false unless self.privacy
  end
end
