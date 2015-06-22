require_relative 'questions_database'
require_relative 'user'
require_relative 'question'
require_relative 'db_interfaceable'
require_relative 'saveable'

class Reply
  extend DBInterfaceable
  include Saveable

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
end

if __FILE__ == $PROGRAM_NAME

  reply_again = Reply.find_by_id(1)
  p reply_again

end
