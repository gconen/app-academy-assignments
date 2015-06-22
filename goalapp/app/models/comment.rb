# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  body             :text             not null
#  author_id        :integer          not null
#  commentable_id   :integer          not null
#  commentable_type :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ActiveRecord::Base
  validates :body, :author_id, :commentable_id, :commentable_type, presence: true
  belongs_to :commentable, polymorphic: true
  belongs_to :author, class_name: "User"
  validates :commentable_id, uniqueness: { scope: :commentable_type }
end
