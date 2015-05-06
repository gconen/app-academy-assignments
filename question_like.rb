require_relative 'questions_database'

class QuestionLike
  def self.find_by_id(id)
    hash = QuestionsDatabase.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
    SQL
    
    self.new(hash.first)
  end

  attr_accessor :id, :question_id, :user_id

  def initialize(args = {})
    @id = args['id']
    @user_id = args['user_id']
    @question_id = args['question_id']
  end
end
