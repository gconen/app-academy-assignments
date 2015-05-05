require_relative 'questions_database'
require_relative 'question'
require_relative 'reply'

class User
  def self.find_by_id(id)
    hash = QuestionsDatabase.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL

    self.new(hash.first)
  end

  def self.find_by_name(first, last)
    hash = QuestionsDatabase.execute(<<-SQL, first, last)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL
    self.new(hash.first)
  end

  attr_accessor :id, :fname, :lname

  def initialize(attrs = {})
    @id, @fname, @lname = attrs['id'], attrs['fname'], attrs['lname']
  end

  def authored_questions
    Question.find_by_author_id(id)
  end

  def authored_replies
    Reply.find_by_user_id(id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(id)
  end

  def popularity
    query_result = QuestionsDatabase.execute(<<-SQL, id)
      SELECT
        COUNT(DISTINCT questions.id) AS question_count,
        COUNT(question_follows.user_id) AS follower_count
      FROM
        questions
      LEFT OUTER JOIN
        question_follows ON question_follows.question_id = questions.id
      WHERE
        questions.author_id = ?
    SQL

    question_count = query_result[0]['question_count']
    follower_count = query_result[0]['follower_count']
    follower_count / question_count.to_f
  end

  def create
    raise 'already saved!' unless self.id.nil?

    QuestionsDatabase.execute(<<-SQL, fname, lname)
      INSERT INTO
        users (fname, lname)
      VALUES
        (? , ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def save
    QuestionsDatabase.execute(<<-SQL, fname, lname, id)
      UPDATE
        users
      SET
        fname = ?
        lname = ?
      WHERE
        id = ?
    SQL
  end
end


if __FILE__ == $PROGRAM_NAME

  user = User.find_by_id(1)
  p user.popularity

end
