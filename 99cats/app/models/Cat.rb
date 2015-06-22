# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date
#  color       :string           not null
#  name        :string           not null
#  sex         :string           not null
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Cat < ActiveRecord::Base
  VALID_COLORS = ["white", "black", "brown", "orange"]

  validates :color, :name, :sex, presence: true
  validates :color, inclusion: { in: VALID_COLORS,
                                message: "not valid"}
  validates :sex, inclusion: { in: ['m', 'f'],
                                message: "not valid"}

  has_many :cat_rental_requests, dependent: :destroy

  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  def self.cat_names
    cat_names = {}
    Cat.all.each do |cat|
      cat_names[cat.id] = cat.name
    end

    cat_names
  end

  def age
    return nil if birth_date.nil?
    ((Date.today - birth_date).to_i / 365).to_s + " years old"
  end

  def gender
    sex == 'm' ? "Male" : "Female"
  end

end
