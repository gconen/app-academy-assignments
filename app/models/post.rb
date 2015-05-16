class Post < ActiveRecord::Base
  validates :title, :author_id, :subs, presence: true

  has_many :post_subs, inverse_of: :post
  has_many :subs, through: :post_subs, source: :sub
  has_many :comments

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )
end
