# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  username   :string           default("unknown"), not null
#

class User < ActiveRecord::Base
 validates :username, presence: true, uniqueness: true

 has_many(
   :contacts,
   class_name: 'Contact',
   foreign_key: :user_id,
   primary_key: :id,
   dependent: :destroy
 )

 has_many(
   :contact_shares,
   class_name: "ContactShare",
   foreign_key: :user_id,
   primary_key: :id,
   dependent: :destroy
 )

 has_many(
  :shared_contacts,
  through: :contact_shares,
  source: :contact
 )

end
