require_relative 'questions_database'
require_relative 'user'
require_relative 'question'

class QuestionFollow
  extend DBInterfaceable

  def self.followers_for_question_id(question_id)
    hashes = QuestionsDatabase.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        users
      INNER JOIN
        question_follows ON users.id = question_follows.user_id
      WHERE
        question_follows.question_id = ?
    SQL

    hashes.map{ |row| User.new(row) }
  end

  def self.followed_questions_for_user_id(user_id)
    hashes = QuestionsDatabase.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        questions
      INNER JOIN
        question_follows ON question_follows.question_id = questions.id
      WHERE
        question_follows.user_id = ?
    SQL

    hashes.map{ |row| Question.new(row) }
  end

  def self.most_followed_questions(n)
    hashes = QuestionsDatabase.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        questions
      INNER JOIN
        question_follows ON question_follows.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(question_follows.user_id) DESC LIMIT ?
    SQL

    hashes.map { |row| Question.new(row) }
  end

  attr_accessor :id, :question_id, :user_id

  def initialize(args = {})
    @id  = args['id']
    @question_id = args['question_id']
    @user_id = args['user_id']
  end
end

if __FILE__ == $PROGRAM_NAME
  p QuestionFollow.most_followed_questions(5)
end
