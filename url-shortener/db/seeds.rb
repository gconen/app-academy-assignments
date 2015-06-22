# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = (0...10).map { |i| User.create!(email:('user' + i.to_s + "@email.com")) }

urls = (0...10).map do |i|
  ShortenedUrl.create_for_user_and_long_url!(users[i], 'www.google.com')
end

topic = TagTopic.create!(topic: "Generic Tag")

%w(news music sports).each { |topic| TagTopic.create!(topic: topic) }

topic.urls << urls[0]
topic.urls << urls[1]

urls[0].visitors << users[0]
urls[1].visitors << users[1]
urls[1].visitors << users[0]
