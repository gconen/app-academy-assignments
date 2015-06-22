class User < ActiveRecord::Base
  validates :name, presence: true


  has_many(
    :authored_polls,
    class_name: "Poll",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: "Response",
    foreign_key: :user_id,
    primary_key: :id
  )

  def completed_polls
    Poll.find_by_sql([<<-SQL, User.last.id])
      SELECT
        polls.*
      FROM
        polls
      INNER JOIN
        questions ON questions.poll_id = polls.id
      INNER JOIN
        answer_choices ON answer_choices.question_id = questions.id
      LEFT OUTER JOIN
        (
          SELECT
            *
          FROM
            responses
          WHERE
            responses.user_id = ?
            ON responses.answer_choice_id = answer_choices.id

      GROUP BY
        polls.id
      HAVING
        COUNT(DISTINCT questions.id) = COUNT(responses.id);
    SQL
  end
end


# Poll.all.joins(:questions)
#   .joins("INNER JOIN answer_choices ON answer_choices.question_id = questions.id")
#   .joins(<<-SQL, self.id)
#     LEFT OUTER JOIN
#     (
#       SELECT
#         *
#       FROM
#         responses
#       WHERE
#         responses.user_id = ?
#     ) as user_responses
#     ON user_responses.answer_choice_id = answer_choices.id
#     SQL
#   .group("polls.id")
#   .having("COUNT(DISTINCT questions.id) = COUNT(user_responses.id)")
#   .select("polls.*")
