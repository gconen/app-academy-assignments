SQ
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
    responses ON user_responses.answer_choice_id = answer_choices.id
  WHERE
    response.user_id = ?
  GROUP BY
    polls.id
  HAVING
    COUNT(DISTINCT questions.id) = COUNT(user_responses.id);
