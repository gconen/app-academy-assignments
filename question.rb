require_relative 'questions_database'
require_relative 'user'
require_relative 'reply'
require_relative 'question_follow'
require_relative 'saveable'

class Question
  extend DBInterfaceable
  include Saveable

  def self.find_by_author_id(author_id)
    hash = QuestionsDatabase.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
    SQL

    self.new(hash.first)
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  attr_accessor :id, :title, :body, :author_id

  def initialize(args = {})
    @id = args['id'],
    @title = args['title']
    @body = args['body']
    @author_id = args['author_id']
  end

  def author
    User.find_by_id(author_id)
  end

  def replies
    Reply.find_by_question_id(id)
  end

  def followers
    QuestionFollow.followers_for_question_id(id)
  end

end

if __FILE__ == $PROGRAM_NAME

  question = Question.find_by_author_id(1)
  p question
  p question.followers

end
