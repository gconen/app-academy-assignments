require_relative 'questions_database'
require_relative 'user'
require_relative 'question'

class Reply
  def self.find_by_id(id)
    hash = QuestionsDatabase.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL

    self.new(hash.first)
  end

  def self.find_by_user_id(user_id)
    hashes = QuestionsDatabase.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL

    hashes.map do |instance|
      self.new(instance)
    end
  end

  def self.find_by_question_id(question_id)
    hashes = QuestionsDatabase.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL

    hashes.map do |instance|
      self.new(instance)
    end
  end

  def self.find_by_parent_id(parent_id)
    hashes = QuestionsDatabase.execute(<<-SQL, parent_id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL

    hashes.map do |instance|
      self.new(instance)
    end
  end

  attr_accessor :id, :question_id, :parent_id, :user_id, :body

  def initialize(args = {})
    @id = args['id']
    @question_id = args['question_id']
    @parent_id = args['parent_id']
    @user_id = args['user_id']
    @body = args['body']
  end

  def author
    User.find_by_id(user_id)
  end

  def question
    Question.find_by_id(question_id)
  end

  def parent_reply
    return nil if parent_id == nil
    Reply.find_by_id(parent_id)
  end

  def child_replies
    Reply.find_by_parent_id(id)
  end

  def create
    raise 'already saved!' unless self.id.nil?

    QuestionsDatabase.execute(<<-SQL, question_id, parent_id, user_id, body)
      INSERT INTO
        replies (question_id, parent_id, user_id, body)
      VALUES
        (?, ?, ?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def save
    if self.id.nil?
      create
      return
    end

    QuestionsDatabase.execute(<<-SQL, question_id, parent_id, user_id, body, id)
      UPDATE
        replies
      SET
        question_id = ?, parent_id = ?, user_id = ?, body = ?
      WHERE
        id = ?
    SQL
  end
end

if __FILE__ == $PROGRAM_NAME

  Reply.new({ 'question_id' => 1, 'body' => "Replying top level" }).save
  reply_again = Reply.find_by_question_id(1)
  p reply_again

end
