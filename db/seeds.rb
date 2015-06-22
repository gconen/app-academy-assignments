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
empty_poll = Poll.create!(title: "empty poll", author_id: author.id)
unanswered_poll = Poll.create!(title: "UA poll", author_id: author.id)
ua_q = Question.create!(text: "unanswered?", poll_id: unanswered_poll.id)
AnswerChoice.create!(text: "choice", question_id: ua_q.id)
partial_poll = Poll.create!(title: "partial poll", author_id: author.id)
q = Question.create!(text: "unanswered?", poll_id: partial_poll.id)
AnswerChoice.create!(text: "choice", question_id: q.id)
q = Question.create!(text: "unanswered?", poll_id: partial_poll.id)
a = AnswerChoice.create!(text: "choice", question_id: q.id)
10.times do |i|
  Response.create!(user_id: respondents[i].id, answer_choice_id: a.id)
end
