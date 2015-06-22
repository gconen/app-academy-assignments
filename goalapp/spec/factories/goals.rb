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

FactoryGirl.define do
  factory :goal do
    name "MyString"
body "MyString"
user_id 1
  end

end
