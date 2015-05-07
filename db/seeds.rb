# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

author = User.create!(name: "sample author")
respondents = []
10.times { |i| respondents << User.create!(name: "#{i}") }
poll = Poll.create!(title: "sample poll", author_id: author.id)
q = Question.create!(text: "sample question?", poll_id: poll.id)
a = []
10.times do |i|
    a <<  AnswerChoice.create!(text: "#{i}", question_id: q.id)
end
10.times do |i|
  Response.create!(user_id: respondents[i].id, answer_choice_id: a[i].id)
end
